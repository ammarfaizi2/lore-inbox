Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVANQiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVANQiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVANQiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:38:18 -0500
Received: from galaxy.systems.pipex.net ([62.241.162.31]:49294 "EHLO
	galaxy.systems.pipex.net") by vger.kernel.org with ESMTP
	id S261723AbVANQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:33:28 -0500
Date: Fri, 14 Jan 2005 16:34:29 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Subject: booting a kernel compiled with -mregparm=0
Message-ID: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to boot a 2.6.x kernel (on x86_64) compiled with -mregparm=0 
and it does not boot, i.e. hangs at the very first stage.

I know this breaks ABI/x86_64 but the reason I need to compile such a 
kernel is because kdb on x86_64 cannot show the function arguments and the 
only way to make it work that I found was to pass all arguments on the 
stack (then kdb works fine and shows correct values for all arguments). 
But obviously the module and the kernel need to match, otherwise it will 
panic easily; and so I have to use the same argument passing convention in 
the kernel. This is obviously for debugging only, nobody would ever ship 
such "incorrectly" compiled module anywhere.

So, I have to find a "boundary" between the parts of the kernel that can 
be safely compiled with -mregparm=0 and which must stay as they are. Any 
ideas as to what to do in this situation?

Kind regards
Tigran


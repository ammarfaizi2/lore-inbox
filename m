Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbUEAWiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUEAWiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUEAWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:38:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:57477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262459AbUEAWiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:38:19 -0400
Date: Sat, 1 May 2004 15:37:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <20040501201342.GL2541@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
 <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 May 2004, Adrian Bunk wrote:
> 
> It seems the DVB updates broke this.
> 
> Please _undo_ the patch below.

No, there's something wrong. Nobody should use a global "errno" variable, 
and we should fix the real bug (it's probably some buggy system call 
"interface" function that is being used).

Can somebody who sees this problem please try to figure out where the 
buggy user of "errno" is?

		Linus

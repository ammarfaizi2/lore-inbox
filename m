Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWEVSGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWEVSGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWEVSGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:06:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:20369 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751103AbWEVSGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:06:20 -0400
X-Authenticated: #31060655
Message-ID: <4471FD34.8050202@gmx.net>
Date: Mon, 22 May 2006 20:04:36 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>
Subject: [RFC] Consoldidate arch/{i386,x86_64}/boot
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are many differences between the files in
arch/{i386,x86_64}/boot, but it seems most (if not all) of them
have no effect on the generated code and are purely cosmetical.

I have a patch which increases similarity between these
subtrees, while still generating identical code. After that,
only very few differences remain in

compressed/misc.c
video.S
tools/build.c

and it should be possible to unify them and kill one copy of
each.

Would a series of incremental patches to consolidate these two
subtrees get accepted?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

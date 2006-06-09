Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWFIR6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWFIR6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWFIR6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:58:46 -0400
Received: from [80.71.248.82] ([80.71.248.82]:24251 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030210AbWFIR6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:58:45 -0400
X-Comment-To: Jeff Garzik
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<m3y7w69s6v.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091018150.5498@g5.osdl.org>
	<20060609174146.GO1651@parisc-linux.org> <4489B4CB.7060001@garzik.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 22:00:41 +0400
In-Reply-To: <4489B4CB.7060001@garzik.org> (Jeff Garzik's message of "Fri, 09 Jun 2006 13:50:03 -0400")
Message-ID: <m3ac8m9pkm.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMHO, 3 (three) if's for a whole fs don't look that bad.
on the other side, you'd need to audit much more of
almost the same lines ...

thanks, Alex

>>>>> Jeff Garzik (JG) writes:

 JG> With extents and 48bit, you have multiple code paths to audit, regardless.

 JG> If applied to ext3, you have to audit

 JG> 	fs/ext3/*.c:
 JG> 		if (extents)
 JG> 			...
 JG> 		else
 JG> 			...

 JG> as opposed to

 JG> 	fs/ext3/*.c:
 JG> 		...	non-extent code
 JG> 	fs/ext4/*.c:
 JG> 		...	extent code



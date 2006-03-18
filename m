Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWCRSLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWCRSLH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 13:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWCRSLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 13:11:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWCRSLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 13:11:06 -0500
Date: Sat, 18 Mar 2006 10:10:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Janak Desai <janak@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       ebiederm@xmission.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@ftp.linux.org.uk, hch@lst.de, mtk-manpages@gmx.net, ak@muc.de,
       paulus@samba.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] for 2.6.16, disable unshare_vm()
In-Reply-To: <441C4636.15F57F6@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0603181007020.3826@g5.osdl.org>
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com> 
 <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>  <441AF596.F6E66BC9@tv-sign.ru>
 <20060317125607.78a5dbe4.akpm@osdl.org> <441C0741.3BC25010@tv-sign.ru>
 <441C2AA0.3080200@us.ibm.com> <441C4263.B779CDA8@tv-sign.ru>
 <441C4636.15F57F6@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Mar 2006, Oleg Nesterov wrote:
>
> sys_unshare() does mmput(new_mm). This is not enough
> if we have mm->core_waiters. This patch is a temporary
> fix for soon to be released 2.6.16.

Yes. Quick raising of hands: is there anybody out there that expects to 
use unshare(CLONE_VM) right now? One of the reasons it was integrated was 
that I thought glibc wanted it for distros. Is disabling the CLONE_VM 
unsharing going to impact that?

		Linus

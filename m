Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWEVUQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWEVUQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 16:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWEVUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 16:16:36 -0400
Received: from xenotime.net ([66.160.160.81]:58754 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751126AbWEVUQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 16:16:35 -0400
Date: Mon, 22 May 2006 13:19:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, haveblue@us.ibm.com, akpm@osdl.org
Subject: Re: [PATCH 4/9] namespaces: utsname: switch to using uts namespaces
Message-Id: <20060522131902.7e30e6f0.rdunlap@xenotime.net>
In-Reply-To: <44721469.5000601@fr.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518154936.GE28344@sergelap.austin.ibm.com>
	<20060518170234.07c8fe4c.rdunlap@xenotime.net>
	<44721469.5000601@fr.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006 21:43:37 +0200 Cedric Le Goater wrote:

> Randy.Dunlap wrote:
> >>
> >> 9ee063adf4d2287583dbb0a71d1d5f80d7ae011f
> >> diff --git a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
> >> index 8fdb1fb..4af731d 100644
> >> --- a/arch/i386/kernel/sys_i386.c
> >> +++ b/arch/i386/kernel/sys_i386.c
> >> @@ -210,7 +210,7 @@ asmlinkage int sys_uname(struct old_utsn
> >>  	if (!name)
> >>  		return -EFAULT;
> >>  	down_read(&uts_sem);
> >> -	err=copy_to_user(name, &system_utsname, sizeof (*name));
> >> +	err=copy_to_user(name, utsname(), sizeof (*name));
> > 
> > It would be really nice if you would fix spacing while you are here,
> > like a space a each side of '='.
> > 
> > and a space after ',' in the function calls below.
> 
> Here's a possible cleanup on top of serge's patchset as found in
> 2.6.17-rc4-mm3.

Yes, thanks, looks good.

---
~Randy

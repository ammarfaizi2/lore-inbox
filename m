Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVGRCqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVGRCqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 22:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVGRCqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 22:46:33 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:61888 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261489AbVGRCqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 22:46:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UKTXZLDpGV2cPtvhWKLPdfvdJezVE1Zwu+D/WKe3PiAahjxKnkkXjaNcv1ApFRUVQrZB5HVMoHNACkX+tSY69SVTe9cjIx1VsA0eJuAJaxwSrtfYZRap5RRpzk/Q2rYBX2XrVbdn+Y8w6RcfwZMyMFR7+P05hjoTlSHAJoSj2QI=
Message-ID: <1e62d13705071719462d437a21@mail.gmail.com>
Date: Mon, 18 Jul 2005 07:46:32 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: "porranenhuma@globo.com" <porranenhuma@globo.com>
Subject: Re: Kernel Panic: VFS cannot open a root device
Cc: Norbert van Nobelen <norbert@edusupport.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <428C48BA000CBFCB@riosf03.globoi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507171016.37940.norbert@edusupport.nl>
	 <428C48BA000CBFCB@riosf03.globoi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/05, porranenhuma@globo.com <porranenhuma@globo.com> wrote:
> I already done that things , and I still getting these errors ... I dont
> no what to do , and I'm getting desesperated...
> 
>  '>'
>  '>'You should compile in the filesystem (reiserfs?) into the kernel (*
> instead
>  '>'of
>  '>'M), or put the correct module in initrd (usually done by mkinitrd).
> 
>  '>'After that run lilo, and it should boot just fine.
>  '>'
>  '>'Norbert
>  '>'
>  '>'Op zaterdag 16 juli 2005 20:57, schreef u:
>  '>'> > Hi , i have kernel 2.4.29 at slack 10.1 and when I upgrade my kernel
>  '>'to
>  '>'> > 2.6.11 I get these erros on booting
>  '>'> >
>  '>'> > VFS: Cannot open a root device "301" or unknow block
>  '>'> > please append a correct "root" boot option
>  '>'> > KERNEL PANIC :  not syncing; VFS; Unable to mount root fs on
>  '>'> > unknown-block (3,1)
>  '>'> >
>  '>'> > I have compiled my kernel with my IDE support and also with my file
>  '>'> > system support with built-in option.
>  '>'> >
>  '>'> > My LILO.CONF
>  '>'> > image = /boot/vmlinuz-2.6.11
>  '>'> > root = /dev/hda1
>  '>'> > label = 2.6.11
>  '>'> > initrd = /boot/initrd.gz
>  '>'> > read-only
>  '>'> >

I saw this prob when my boot device/partition in the bootloader config
was wrong or the filesystem of my root partition is not compiled as a
kernel image rather compiled as module, so plz try to solve this prob
by selecting your desired filesystem in kernel configuration as Y
rather than M ...... I hope this will work

>  '>'> > I'm booting with my image of kernel 2.4.29..... i'm 5 days tryng
> to solve
>  '>'> > this problem ...

Upgrading from 2.4.xx kernel series to 2.6.xx series what I found is
that the filesystem must be compiled into the kernel image not as a
module b/c in 2.4.xx filesystem compiled as module also work ........

And another thing is that I never succedded in booting the 2.6.xx
kernel __successfully__ compiled from 2.4.xx series (distribution with
default 2.4.xx series kernel like Fedora Core 1 or Redhat Linux 9) and
found that my mouse won't work on 2.6.xx series kernel, but the
distribution with 2.6.xx kernel series by default works fine .....


-- 
Fawad Lateef

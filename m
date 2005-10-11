Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVJKBsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVJKBsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 21:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVJKBsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 21:48:41 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:53601 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751344AbVJKBsk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 21:48:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYMkzAFSa+/WnsmO3Re+zrgx1Vd+ier2dMcHULZF32dXwKLxBpfCn3jaflOdhXYO9OLNZTk7CoVOrBK3c6YTSI3Oo4gpWo6l3adstGs/eA+RdY8GexgBGCQjXMnuwvVow1k2kPjEx6nkDapJsbwnJXyMz1gINQYkTCh9/hr+wt4=
Message-ID: <2cd57c900510101848l5ecaa7e3p134f2e51950ab277@mail.gmail.com>
Date: Tue, 11 Oct 2005 09:48:39 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <431DFEC3.1070309@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>
	 <20050831215757.GA10804@taniwha.stupidest.org>
	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>
	 <431DFEC3.1070309@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Alon Bar-Lev wrote:
> >
> > Hello Peter, I've written a reply before but got no response...
> >
> > The idea of putting arguments in initramfs is not practical, since the
> > whole idea is to have the same image of system and affecting its
> > behavior using the boot loader...
> >
>
> No, you're wrong.  The boot loader can synthesize an initramfs.
>
> > I would like to push forward the idea to extend the command-line size...
> >
> > All we need for start is an updated version of the "THE LINUX/I386 BOOT
> > PROTOCOL" document that states that in the 2.02+  protocol the boot
> > loader should set cmd_line_ptr to a pointer to a null terminated string
> > without any size restriction, specifying that the kernel will read as
> > much as it can.
>
> Already pushed to Andrew.  I will follow it up with a patch to extend
> the command line, at least to 512.
>
> > After I get this update, I will try to work with GRUB and LILO so that
> > they will fix their implementation. Currently they claim that they
> > understand that they should truncate the string to 256.
> >
> > After that I will provide my simple  patch for setting the maximum size
> > the kernel allocates in the configuration.
> >
> > BTW: Do you know why the COMMAND_LINE_SIZE constant is located in two
> > separate include files?
>
> No, I don't.  It could be because one is included from assembly code in
> the i386 architecture.


The kernel uses the setup.h COMMAND_LINE_SIZE for both assembly and C
code. COMMAND_LINE_SIZE in param.h is only for bootloader IMHO.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/

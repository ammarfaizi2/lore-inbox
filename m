Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272231AbTHRTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272274AbTHRTE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:04:28 -0400
Received: from [63.247.75.124] ([63.247.75.124]:41879 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272231AbTHRTEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:04:22 -0400
Date: Mon, 18 Aug 2003 15:04:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030818190421.GN24693@gtf.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <lRjg.6o4.15@gated-at.bofh.it> <lWLS.39x.5@gated-at.bofh.it> <lWLZ.39x.29@gated-at.bofh.it> <3F4120DD.3030108@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4120DD.3030108@softhome.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:54:21PM +0200, Ihar 'Philips' Filipau wrote:
> Jeff Garzik wrote:
> >>hpa IIRC suggested to create a separate directory:
> >>include/abi
> >>and then all relevant parts of the kernel should publish their public
> >>interface in the abi directory. Would that be usefull?
> >
> >
> >I support include/abi, or some other directory that segregates
> >user<->kernel shared headers away from kernel-private headers.
> >
> >I don't see how that would be auto-generated, though.  Only created
> >through lots of hard work :)
> >
> 
>    There is no need to be a prophet to predict linux/abi being 99% 
> symlinks right into include/{asm,linux}.
> 
>    So it is can turn out to be the same ;-)
>    It just adds job for mantainers.
>    (To keep symlinks in correct order ;-)))))
> 
>    But generally idea is good: keep interface separately from 
> implementation.

No, the idea is to physically separate the headers.

include/{linux,asm} is currently copied to userspace, hacked a bit,
and then shipped as the "glibc-kernheaders" package.

I would rather that the kernel developers directly maintained this
interface, by updating headers in include/abi, rather than ad-hoc by
distro people.

	Jeff



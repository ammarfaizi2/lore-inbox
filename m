Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWDFP1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWDFP1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 11:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWDFP1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 11:27:44 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:57566 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932185AbWDFP1n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 11:27:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tIEqXp5EDc8N3dphI89xu5aJFzpvefBRRAPaFZpc+wjbJqMRlIe4H598vYBQVJ9vFs7vgG2pUgoAWc7HaJbD4/kUF7imV0JwyyrHJOuqC/Kk0DILriWQE+naRdCQULsk1O6RJayZktP40xGcBl0p1LIeOaFENsLujAapbAQ0Snc=
Message-ID: <c70ff3ad0604060827m6c286965p5a92374347a8a1f0@mail.gmail.com>
Date: Thu, 6 Apr 2006 18:27:43 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Paolo Ornati" <ornati@fastwebnet.it>
Subject: Re: add new code section for kernel code
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060406151003.0ef4e637@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

very cooooooooool!!
regarding the readprofile, I think it's recommended to mention that
functions called within spinlocks won't show up.


On 4/6/06, Paolo Ornati <ornati@fastwebnet.it> wrote:
> On Thu, 6 Apr 2006 15:45:47 +0300
> "saeed bishara" <saeed.bishara@gmail.com> wrote:
>
> >  I'm developing linux kernel for ARM cpu with direct-mapped
> > instruction cache, sometimes I notice that the pefromance of the
> > kernel (for some test) is highly dependent on the code layout, in
> > order to fix that I added new code section, and for each kernel
> > function that highly invokerd I added compiler attribute so it will
> > allocated in that section (exactly as the __init section)
>
> It's already done in 2.6.17-rc1 for x86_64:
>
> Processor type and feature --> Function reordering
>
> arch/x86_64/Kconfig:
>
> config REORDER
>         bool "Function reordering"
>         default n
>         help
>          This option enables the toolchain to reorder functions for a more
>          optimal TLB usage. If you have pretty much any version of binutils,
>          this can increase your kernel build time by roughly one minute.
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4bdc3b7f1b730c07f5a6ccca77ee68e044036ffc
>
> --
>         Paolo Ornati
>         Linux 2.6.16.1 on x86_64
>

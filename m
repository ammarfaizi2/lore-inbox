Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWDIJx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWDIJx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 05:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDIJx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 05:53:57 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:38104 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbWDIJx5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 05:53:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hh5jHIB7Xet29eqFe7YUVbxbHbiiLKl5CrQIoMj45g8MF5sVqGyv0E183Er2LsuN3RR/TPXK/B+2vfQIp+nJZ+4tze60DFV3YV+uspq6XaD4hS8VduLUb+o3GNTtZpzbhCyREaYWLyRJNSbi4S6t/L/VSIMEc5yHaJrcUQ49LfY=
Message-ID: <c70ff3ad0604090253n7fe4de4che67f18380ffa2efd@mail.gmail.com>
Date: Sun, 9 Apr 2006 12:53:56 +0300
From: "saeed bishara" <saeed.bishara@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>,
       "saeed bishara" <saeed.bishara@gmail.com>,
       "Paolo Ornati" <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
Subject: Re: add new code section for kernel code
In-Reply-To: <20060407154349.GB31458@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
	 <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
	 <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
	 <1144422864.3117.0.camel@laptopd505.fenrus.org>
	 <20060407154349.GB31458@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd prefer not to paper over such bugs.  Maybe the following patch will
> fix the decompressor for saeed?

yes, this patch fixed the problem.

>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
> --- a/arch/arm/boot/compressed/vmlinux.lds.in
> +++ b/arch/arm/boot/compressed/vmlinux.lds.in
> @@ -18,6 +18,7 @@ SECTIONS
>      _start = .;
>      *(.start)
>      *(.text)
> +    *(.text.*)
>      *(.fixup)
>      *(.gnu.warning)
>      *(.rodata)
>
>
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
>

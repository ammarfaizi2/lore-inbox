Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030314AbWAaDeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWAaDeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWAaDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:34:23 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:58205 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030304AbWAaDeX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:34:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c2wubbnEZL7RHAGDOSadBii94J3XBWdOIMKa8Rkn+XV4noro40JTcej4+Jbz/SKz5nR+CmBFtqI2zqpLaYizzjh4kZ+SWFPEe8R7xMccJysLIoGrVhjaPClTwXgRZ9AwWnLVgBvb+arv25V5s7G+/xhUvbZ+j+9mmtVa2sOtucA=
Message-ID: <29495f1d0601301934x1f4b7925w19261f457117637a@mail.gmail.com>
Date: Mon, 30 Jan 2006 19:34:21 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "L. A. Walsh" <lkml@tlinx.org>
Subject: Re: i386 requires x86_64?
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43DED532.5060407@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43DED532.5060407@tlinx.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/06, L. A. Walsh <lkml@tlinx.org> wrote:
> Generating a new kernel and wanted to delete the unrelated architectures.
>
> Is the i386 supposed to depend on the the x86_64 architecture?
>
> In file included from arch/i386/kernel/acpi/earlyquirk.c:8:
> include/asm/pci-direct.h:1:35: asm-x86_64/pci-direct.h: No such file or
> directory

You didn't say which kernel, but it looks like you didn't do a make
clean/mrproper before trying to build just an i386 kernel? Did you
build an x86_64 kernel at some point from the same tree?

I think that include/asm is pointing to asm-x86_64, which, if you
removed it, is why the compiler can't find said file.

Thanks,
Nish

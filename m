Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUL1VPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUL1VPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUL1VPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:15:31 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:34263 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261257AbUL1VP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kV/QVMqouhhLB+b1CjlB4gxDgPb7kKnbi9L7fZ2F/vQ5+VTBmYVjk5ekS/oXxQnb+VDB04JJGJiRwEF6u6XZf7vjwbH7bYARi9w4F7//Z5oKGmiLPZXQS2qquUQJJ88R7cu0cAEZ5MCvNTu/TwIRZAAs0+5i1AW42e5t6LnV6AY=
Message-ID: <58cb370e04122813152759d94f@mail.gmail.com>
Date: Tue, 28 Dec 2004 22:15:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: PATCH: 2.6.10 - Incorrect return from PCI ide controller
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20041228205553.GA18525@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104158258.20952.44.camel@localhost.localdomain>
	 <20041228205553.GA18525@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 21:55:53 +0100, Francois Romieu
<romieu@fr.zoreil.com> wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> :
> > Several IDE drivers return positive values as errors in the PCI setup
> > code. Unfortunately the PCI layer considers positive values as success
> > so the driver skips the device but still claims it and things then go
> > downhill.
> >
> > This fixes the IT8172 driver. There are other drivers with this bug (eg
> > generic) but the -ac IDE is sufficiently diverged from base that someone
> > else needs to generate/test the more divergent cases.
> 
> ide_setup_pci_device{s} will always claim that everything is fine even
> though do_ide_setup_pci_device() has some opportunity to fail.
> 
> Should it matter as well ?

Yes.  Patches welcomed.

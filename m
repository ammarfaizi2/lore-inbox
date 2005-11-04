Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030555AbVKDBe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030555AbVKDBe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbVKDBe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:34:56 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:55475 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030555AbVKDBez convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:34:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WM0NT88LMedSFiOLJ1tvv+/326n6AIeBh1Avx055x31/A9spQQz5kHsg7X4QmC6JJhzxk2rmYEtfBuoew9fZkI3GCGSoWYRZexd0Sfg2teQXvk7eCAcYvzo0SFKpNMgwhMIMG/HZsISdGSEDeSlcmVK2r6hRUpBTuP7NxYw2deQ=
Message-ID: <4807377b0511031734gfc23c5fm31050bc8ee47c0c5@mail.gmail.com>
Date: Thu, 3 Nov 2005 17:34:53 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: linas@austin.ibm.com
Subject: Re: [PATCH 29/42]: ethernet: add PCI error recovery to e100 dev driver
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051104005353.GA27074@mail.gnucash.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103235918.GA25616@mail.gnucash.org>
	 <20051104005353.GA27074@mail.gnucash.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Linas Vepstas <linas@linas.org> wrote:
> Various PCI bus errors can be signaled by newer PCI controllers.  This
> patch adds the PCI error recovery callbacks to the intel ethernet e100
> device driver. The patch has been tested, and appears to work well.
>
> Signed-off-by: Linas Vepstas <linas@linas.org>
>
> --
> Index: linux-2.6.14-git3/drivers/net/e100.c

I think these patches will be great, on the pseries, but
is there not a compile option that should compile out all this code, i.e.
#ifdef PCI_ERROR_RECOVERY

if the arch doesn't support it?

Jesse

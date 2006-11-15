Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030659AbWKOQag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030659AbWKOQag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030662AbWKOQag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:30:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:737 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030659AbWKOQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:30:35 -0500
Date: Wed, 15 Nov 2006 16:35:56 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] pci: Introduce pci_find_present
Message-ID: <20061115163556.0937531e@localhost.localdomain>
In-Reply-To: <1163608000.31358.134.camel@laptopd505.fenrus.org>
References: <20061115162445.641eb321@localhost.localdomain>
	<1163608000.31358.134.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 17:26:39 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2006-11-15 at 16:24 +0000, Alan wrote:
> > This works like pci_dev_present but instead of returning boolean returns
> > the matching pci_device_id entry. This makes it much more useful. Code
> > bloat is basically nil as the old boolean function is rewritten in terms
> > of the new one.
> > 
> 
> shouldn't this take a refcount on the device (which the user of this
> function then has to put again) ?

Nope. It is returning a pci_device_id from an array of pci_device_id
values that were passed into the function. It is not returning a pci
device so it does not require refcounts.

Alan

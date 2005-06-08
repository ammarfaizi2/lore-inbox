Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVFHFze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVFHFze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 01:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVFHFze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 01:55:34 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:54860 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262112AbVFHFz1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 01:55:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GcitaCJvdyx7RHfhSYYT/SWpVSTSSREXyg4h/9RrBsW/mb4sO85gMUMUcEMrlP2ZLM7UK8p6Ri+IkZGrFQ0B7cpE5eDmeZqaskNOvEqYc60nOVyQXUjPoCLSMTQMbJ8SWig3gi8seU+k300is7JxfipT0S5uXZbiHHMSA/+LWd0=
Message-ID: <c0a09e5c05060722558a86ac8@mail.gmail.com>
Date: Tue, 7 Jun 2005 22:55:27 -0700
From: Andrew Grover <andy.grover@gmail.com>
Reply-To: Andrew Grover <andy.grover@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Cc: Greg KH <gregkh@suse.de>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
In-Reply-To: <42A61CDE.6090906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>
	 <42A61CDE.6090906@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> If the driver has to _undo_ something that it did not do, that's pretty
> lame.  Non-orthogonal.

I would think the number of MSI and MSI-X capable devices is going to
explode over the next five years. I'm not sure it's right to make all
these device's drivers pay a complexity cost because some of the first
attempted MSI implementations were buggy.

> Also, it looks like all the PCI MSI drivers need touching for this
> scheme -- which defeats the original intention.  At this rate, the best
> API is the one we've already got.

For now...but I'm bringing this up again in five years!! *sets egg timer*

-- Andy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753083AbWKFOTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbWKFOTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbWKFOTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:19:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20414 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753083AbWKFOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:19:21 -0500
Subject: Re: [PATCH] add pci revision id to struct pci_dev
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Conke Hu <conke.hu@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1162819681.1566.63.camel@localhost.localdomain>
References: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
	 <1162819681.1566.63.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 15:19:17 +0100
Message-Id: <1162822757.3138.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 13:28 +0000, Alan Cox wrote:
> Ar Llu, 2006-11-06 am 20:40 +0800, ysgrifennodd Conke Hu:
> > Hi all,
> >     PCI revision id had better be added to struct pci_dev and
> > initialized in pci_scan_device.
> 
> You can read the revision any time you like, we don't need to cache a
> copy as we don't reference it very often

one consideration is that if you read it from the hw you can't actually
fix it up in quirks at all, so it might make a lot of sense to just also
store it in the pci device struct, it's a very logical thing esp since
the pci device/vendor ids are stored there too (and those you can also
read from the hw if you want ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


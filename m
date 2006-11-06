Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWKFOae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWKFOae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbWKFOae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:30:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44494 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751963AbWKFOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:30:33 -0500
Subject: Re: [PATCH] add pci revision id to struct pci_dev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Conke Hu <conke.hu@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1162822757.3138.32.camel@laptopd505.fenrus.org>
References: <5767b9100611060440i1149e0e3v2162e0604db10da7@mail.gmail.com>
	 <1162819681.1566.63.camel@localhost.localdomain>
	 <1162822757.3138.32.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Nov 2006 14:34:58 +0000
Message-Id: <1162823699.1566.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-11-06 am 15:19 +0100, ysgrifennodd Arjan van de Ven:
> store it in the pci device struct, it's a very logical thing esp since
> the pci device/vendor ids are stored there too (and those you can also
> read from the hw if you want ;)

We need those cached because we iterate them on every PCI device match
and that is both regularly accessed and performance relevant. We also
need to cache them for the removed device case, unlike revision id.

> 

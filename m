Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUBXUgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUBXUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:34:37 -0500
Received: from intra.cyclades.com ([64.186.161.6]:58777 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262443AbUBXUeT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:34:19 -0500
Date: Tue, 24 Feb 2004 18:25:46 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ben Schofield <b.w.schofield@durham.ac.uk>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Toshiba IDE support: drivers/ide/pci/generic.c
In-Reply-To: <401D7E16.5060203@durham.ac.uk>
Message-ID: <Pine.LNX.4.58L.0402241824050.23951@logos.cnet>
References: <401D7E16.5060203@durham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Feb 2004, Ben Schofield wrote:

> Hi all,
>
> I've been having some problems with the IDE controller on my aged
> Portege 3440CT's port replicator, which I think I've now fixed, and I'd
> appreciate someone else's opinion before I submit a patch.
>
> The problem is that the controller reports itself with a vendor ID of
> 1179 (Toshiba) and a device ID of 0105 (unknown). In the 2.4.18 kernel,
> this was fine, since drivers/ide/ide-pci.c recognised it as an unknown
> IDE device and all was well.
>
> Somewhere between 2.4.18 and 2.4.22, the PCI IDE code seems to have been
> re-organised, and ide/generic.c seems not to have all the necessary code
> for unrecognised IDE devices. However, 1179:0103 is listed there as a
> Toshiba Piccolo controller, and adding 1179:0105 with the same data
> makes things work fine.
>
> Toshiba Piccolo support seems to have been removed entirely from
> generic.c in 2.6.2-rc3-bk1. This seems to have affected at least Jérôme
> Augé, who submitted a patch for a similar problem on 08/01 this year,
> containing
>
> #define PCI_DEVICE_ID_TOSHIBA_PICCOLO 0x0102
>
> So, I would guess that it's safe to assume at least 1179:0102, 1179:0103
> and 1179:0105 are Toshiba Piccolo controllers.
>
> Should I submit this as a patch?

Yes please.

> If I should, which kernel versions should I submit it against?

Ideally against 2.6 and 2.4.

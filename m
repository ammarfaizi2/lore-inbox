Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965937AbWKHP5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965937AbWKHP5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965939AbWKHP5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:57:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28348 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965937AbWKHP5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:57:15 -0500
Subject: Re: S2RAM and PCI quirks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1163000924.3138.342.camel@laptopd505.fenrus.org>
References: <1163000705.23956.18.camel@localhost.localdomain>
	 <1163000924.3138.342.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 16:01:51 +0000
Message-Id: <1163001711.23956.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 16:48 +0100, ysgrifennodd Arjan van de Ven:
> at the same time I'm not 100% convinced it's ok to always run all quirks
> at resume, for one the difference is that there now is a driver active
> owning the device... Almost sounds like having a per quirk flag stating
> "run at resume" is needed ;-(

We probably need a quirk class for resume in this situation. The kind of
things that worry me if we are not doing the quirk handling, and what I
suspect happened in the case I looked at are that chipset bug
workarounds did not get restored, and in this case the older VIA chipset
involved then corrupted DMA streams and trashed the users disk.

> (also I think the quirks are currently __init but that's relatively easy
> to fix)

Some are yes, but not others.

Alan


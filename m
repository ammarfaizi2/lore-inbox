Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUDOTmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUDOTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:42:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26250 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262353AbUDOTmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:42:10 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andi Kleen <ak@muc.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: SATA support merge in 2.4.27
Date: Thu, 15 Apr 2004 21:41:18 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <1Ljts-1eQ-29@gated-at.bofh.it> <m37jwhqc2u.fsf@averell.firstfloor.org>
In-Reply-To: <m37jwhqc2u.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404152141.18395.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 of April 2004 21:24, Andi Kleen wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:
> > Jeff Garzik sent me a SATA update to be merged in 2.4.x.
> >
> > A lot of new boxes are shipping with SATA-only disks, and its pretty bad
> > to not have a "stable" series without such industry-standard support.
> >
> > This is the last feature to be merged on 2.4.x, and only because its
> > quite necessary.
> >
> > Any oppositions?
>
> The big problem is that the SATA code will move some disks from
> /dev/hdX to /dev/sdX (e.g. most disks in modern intel chipsets) And
> then the boxes don't boot anymore. It's probably a bad idea to merge
> it.

ICH5 SATA and SiI3112 are the only affected chipsets.
You don't have to enable libata drivers for them or their
PCI IDs can be removed from the libata drivers if needed.

Bartlomiej


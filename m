Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWGGQwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWGGQwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWGGQwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:52:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14506 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932183AbWGGQwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:52:39 -0400
Subject: Re: 2.6.17-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: jamagallon@ono.com, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060707093432.571af16e.rdunlap@xenotime.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <20060705234347.47ef2600@werewolf.auna.net>
	 <20060705155602.6e0b4dce.akpm@osdl.org>
	 <20060706015706.37acb9af@werewolf.auna.net>
	 <20060705170228.9e595851.akpm@osdl.org>
	 <20060706163646.735f419f@werewolf.auna.net>
	 <20060706164802.6085d203@werewolf.auna.net>
	 <20060706234425.678cbc2f@werewolf.auna.net>
	 <20060706145752.64ceddd0.akpm@osdl.org>
	 <1152288168.20883.8.camel@localhost.localdomain>
	 <20060707175509.14ea9187@werewolf.auna.net>
	 <1152290643.20883.25.camel@localhost.localdomain>
	 <20060707093432.571af16e.rdunlap@xenotime.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 18:09:56 +0100
Message-Id: <1152292196.20883.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 09:34 -0700, ysgrifennodd Randy.Dunlap:
> For built-in drivers, the link order matters.
> The the libata PATA drivers are sort of "randomly" mixed in
> with the SATA drivers.

Mine are in alphabetical order but some of the early merges shuffled
stuff a bit.

The only case the link order matters here is with the generic and legacy
drivers. No chip specific libata PATA/SATA driver has overlapping PCI
identifiers between two drivers except for Jmicron, and that
distinguishes precisely by the function number.

Also its dangerous to assume "pata_*" is a PATA driver, it may be SATA
with a bridge chip, and in some cases like the ATI this is quite common.


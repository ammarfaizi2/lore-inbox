Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUHRSfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUHRSfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHRSfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:35:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:20352 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267454AbUHRSeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:34:31 -0400
Subject: Re: [patch] enums to clear suspend-state confusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mochel@digitalimplant.org, benh@kernel.crashing.org,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20040818002711.GD15046@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
	 <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org>
	 <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org>
	 <20040818002711.GD15046@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092850283.26049.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 18 Aug 2004 18:31:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-18 at 01:27, Pavel Machek wrote:
> I can replace suspend_state_t with enum system_state, but it might
> mean that enum system_state will have to be extended with things like
> RUNTIME_PM_PCI_D0 in future... I guess that's easiest thing to do. It
> solves all the problems we have *now*.

Can you not also provide a function

	pci_state_for(system_state)

then most of the drivers don't have to care. It would also be nice
to have a driver flag to indicate which devices can simply be
hotunplug/hotreplugged over a suspend and don't need extra duplicate
code.


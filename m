Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUHRCOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUHRCOD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 22:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUHRCOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 22:14:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:55975 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268581AbUHRCN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 22:13:56 -0400
Subject: Re: [patch] enums to clear suspend-state confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20040818002711.GD15046@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
	 <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org>
	 <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org>
	 <20040818002711.GD15046@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092794687.10506.169.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 12:04:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now, Patrick has some plans with device power managment and they
> included something bigger being passed down to the drivers. I wanted
> to prepare for those plans.
> 
> I can replace suspend_state_t with enum system_state, but it might
> mean that enum system_state will have to be extended with things like
> RUNTIME_PM_PCI_D0 in future... I guess that's easiest thing to do. It
> solves all the problems we have *now*.

Better is to use a typedef then, so that enum can be turned into a
pointer to a structure later on, and drivers using the "helper"
function to_pci_state() would not need any change when that transition
happen.

Ben.



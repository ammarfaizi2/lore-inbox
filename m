Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUHGXud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUHGXud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUHGXud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:50:33 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:23433 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264791AbUHGXub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:50:31 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Solving suspend-level confusion
Date: Sat, 7 Aug 2004 15:14:49 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200407310723.12137.david-b@pacbell.net> <20040806200442.GC30518@elf.ucw.cz>
In-Reply-To: <20040806200442.GC30518@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071514.49498.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 13:04, Pavel Machek wrote:

> > These look to me like "wrong device-level suspend state" cases.
> 
> Actually, suspend-to-disk has to suspend all devices *twices*. Once it
> wants them in "D0 but DMA/interrupts stopped", and once in "D3cold but
> I do not really care power is going to be cut anyway". I do not think
> this can be expressed with PCI states.

How are those different from "PCI_D1" then later "PCI_D3hot"?
I'd understood that loss of VAUX was always possible, so robust
drivers always had to handle resume  from PCI_D3cold.

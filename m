Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUEPRUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUEPRUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUEPRUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:20:54 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:39398 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S263686AbUEPRUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:20:44 -0400
Date: Sun, 16 May 2004 19:20:56 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Sven Wilhelm <wilhelm@icecrash.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with radeonfb
Message-ID: <20040516172056.GA9694@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040516153306.GA4459@dreamland.darkstar.lan> <40A797B3.8080407@icecrash.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A797B3.8080407@icecrash.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, May 16, 2004 at 06:32:51PM +0200, Sven Wilhelm ha scritto: 
> >You compiled in both radeon drivers. The old driver is complaining that
> >the PCI device is already taken by something else. Use only one driver.
> yes I did, but I thought the kernel would decide which driver to use.

PCI drivers claim for themselves a range of IDs (.id_table in struct
pci_driver). A driver cannot "take over" another one, so when the old
radeonfb tries to register itself for the same ID of the new radeonfb it
gets an error. 

Luca
-- 
Home: http://kronoz.cjb.net
Se il  destino di un uomo  e` annegare, anneghera` anche  in un bicchier
d'acqua.
Proverbio yddish

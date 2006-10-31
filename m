Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423357AbWJaO21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423357AbWJaO21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423360AbWJaO21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:28:27 -0500
Received: from cantor.suse.de ([195.135.220.2]:6355 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423357AbWJaO20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:28:26 -0500
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: lspci output needed was Re: Frustrated with Linux, Asus, and nVidia, and AMD
Date: Tue, 31 Oct 2006 15:28:19 +0100
User-Agent: KMail/1.9.5
Cc: Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.nWSYbiDM13Z4b2OlxoSzmqud/lI@ifi.uio.no> <fa.i/oIAoig46I/apLGccQ0BesB0W8@ifi.uio.no> <454432DC.9030006@shaw.ca>
In-Reply-To: <454432DC.9030006@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311528.20013.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are clearly some NVIDIA chipsets which require the override be 
> skipped, and some which require it not be. I think the ball is currently 
> in NVIDIA's court to provide a way of figuring out which chipsets 
> require the quirk and which don't..

My current plan is to switch in 2.6.20 to automatic probing of more pins
for the timer routing (suggested by Tim Hockin, I've got a test patch). 

But that's too risky for .19.

For 2.6.19 we'll likely add some more PCI-IDs disabling the quirk
and a command line option to disable the skip timer override quirk. 

Doing this per PCI ID isn't that bad because afaik Vista certification
requires enabling the HPET table and I assume most boards will get
Vista certification soon. This will force Asus to fix their BIOS.

Can people who use a Nvidia based AM2/SocketF board (especially when they have timer 
troubles but otherwise would be useful too) please report their lspcis in private 
mail to me?

-Andi



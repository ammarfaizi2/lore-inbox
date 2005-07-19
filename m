Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVGSEiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVGSEiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 00:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVGSEiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 00:38:14 -0400
Received: from ns.solnet.cz ([193.165.198.50]:20674 "EHLO solnet.cz")
	by vger.kernel.org with ESMTP id S261944AbVGSEh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 00:37:27 -0400
X-AntiVirus: scanned for viruses by soLNet AVirCheck 2.0.29 (http://www.solnet.cz/avircheck)
Message-ID: <42DC835E.7030301@solnet.cz>
Date: Tue, 19 Jul 2005 06:36:46 +0200
From: =?UTF-8?B?TWFydGluIFBvdm9sbsO9?= <martin.povolny@solnet.cz>
Organization: soLNet, s.r.o.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise TX4200 support?
References: <42DBFC9E.1040607@gentoo.org> <42DC0A99.2010304@solnet.cz> <42DC2F44.7000708@gentoo.org>
In-Reply-To: <42DC2F44.7000708@gentoo.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Hi Martin,
> 
> Martin Povolný wrote:
> 
>> We are succesfully running patched sata_promise with 3 disks in a
>> raid5/raid1 setup. (Patched against ubuntu linux-image 2.6.11-1-686
>> package.)
> 
> 
> Could you please either send in your patch, or tell me which board_
> setting (2037x/20319/20619) the device ID table should include so I can
> write submit one myself.
> 

For me it works with 20319, but I don't understand the difference
between different settings.

*** sata_promise.c	2005-05-11 21:22:20.000000000 +0200
--- sata_promise_new.c	2005-05-11 21:22:02.000000000 +0200
***************
*** 164,171 ****
--- 164,173 ----
  	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
  	  board_20319 },
  	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
  	  board_20319 },
+ 	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+ 	  board_20319 },
  	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
  	  board_20319 },

  	{ }	/* terminate list */

Regards,

-- 
Mgr. Martin Povolný, soLNet, s.r.o.,
+420777714458, martin.povolny@solnet.cz


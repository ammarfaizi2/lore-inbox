Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSKEOWV>; Tue, 5 Nov 2002 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264831AbSKEOWV>; Tue, 5 Nov 2002 09:22:21 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:16910 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264798AbSKEOWU>; Tue, 5 Nov 2002 09:22:20 -0500
Date: Tue, 5 Nov 2002 18:28:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, jgarzik@pobox.com,
       jung-ik.lee@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.45 PCI Fixups for PCI HotPlug
Message-ID: <20021105182802.A4167@jurassic.park.msu.ru>
References: <200211051317.FAA26655@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200211051317.FAA26655@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Nov 05, 2002 at 05:17:10AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 05:17:10AM -0800, Adam J. Richter wrote:
> 	If pci_do_fixups determines that f->vendor and f->device do
> not match the device in question, it will not call the corresponding
> f->hook, so it is OK for that f->hook to point to the address of a
> discarded __init routine that now contains garbage as long as the
> ID's will not match any hot plugged device.

Unless f->device == PCI_ANY_ID. Plus you won't be able to discard
the list itself.

Ivan.

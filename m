Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbTE1NGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbTE1NGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:06:54 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:54764 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264720AbTE1NGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:06:53 -0400
Date: Wed, 28 May 2003 14:21:54 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jakob Kemi <jakob.kemi@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 damaged my nvidia card?
Message-ID: <20030528132153.GA27632@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jakob Kemi <jakob.kemi@telia.com>, linux-kernel@vger.kernel.org
References: <3ED4B42D.4040204@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED4B42D.4040204@telia.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 03:05:49PM +0200, Jakob Kemi wrote:

 > When I run the box with an old PCI card as my primary adapter and the 
 > AGP geforce card as secondary the Geforce card doesnt seem to run it's 
 > VGA BIOS (no boot message).

most (if not all) modern BIOS's have an "Init {AGP/PCI} display first"
option. You may need to fiddle with that.
 
 > X also refuses to detect the Geforce card. 
 > Is it possible that the new console layer or the new agp gart code or 
 > whatever in 2.5.70 poked in the wrong registers and replaced the BIOS 
 > flash rom on the GeForce with garbage?

Extremely unlikely. WRT agpgart, it pokes chipset registers, not
graphic card registers.

It may even be that the two cards you have won't play together.
Try them both _independantly_ before jumping to conclusions about
wiped BIOSes etc.

		Dave


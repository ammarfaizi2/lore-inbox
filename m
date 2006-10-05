Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWJETmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWJETmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWJETmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:42:36 -0400
Received: from ns.suse.de ([195.135.220.2]:22412 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750788AbWJETmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:42:35 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 21:42:29 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de> <45255D34.804@garzik.org>
In-Reply-To: <45255D34.804@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052142.29692.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tel 975 board and a Asus AMD K8 board with PCI Express) please share it.
> 
> Can you then please share the list of known BIOS bugs?

I already did, but here again in detail:

Intel 9x5 hangs when you do any mmconfig access (apparently reference BIOS
fills in bogus address). Check against ACPI resources doesn't catch it
either.

Mac Mini doesn't do any Type1 at all, so a verify pass that checks
mcfg against type1 doesn't work there.

AMD K8 boards with PCI-E bridges have mmconfig only 
on some busses, but not on the internal northbridge busses. 
MCFG can describe this by listing segments, but the contents 
of that on many boards can be described as "fictional" at best.
That is why Linux needs to verify that too.
 
> All I have to do on my machines is work around the disable-mmconfig 
> code, and things start working.

If the choice is between a secret NDA only card with dubious
functionality and booting on lots of modern boards I know what to 
choose.

-Andi
 

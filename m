Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTCEIZB>; Wed, 5 Mar 2003 03:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbTCEIZA>; Wed, 5 Mar 2003 03:25:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8712 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264756AbTCEIZA>; Wed, 5 Mar 2003 03:25:00 -0500
Date: Wed, 5 Mar 2003 08:35:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: "Cameron, Steve" <Steve.Cameron@hp.com>, linux-kernel@vger.kernel.org,
       "Mathiasen, Torben" <Torben.Mathiasen@hp.com>,
       "Ni, Michael" <Michael.Ni@hp.com>
Subject: Re: PCI hotplug question.
Message-ID: <20030305083525.G25251@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	"Cameron, Steve" <Steve.Cameron@hp.com>,
	linux-kernel@vger.kernel.org,
	"Mathiasen, Torben" <Torben.Mathiasen@hp.com>,
	"Ni, Michael" <Michael.Ni@hp.com>
References: <45B36A38D959B44CB032DA427A6E106404513370@cceexc18.americas.cpqcorp.net> <20030305061520.GA26727@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305061520.GA26727@kroah.com>; from greg@kroah.com on Tue, Mar 04, 2003 at 10:15:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 10:15:20PM -0800, Greg KH wrote:
> I can't find my copy of the PCI Hotplug spec right now (and it's not
> free for download anymore...), but I think that once a user presses the
> latch button, the OS _has_ to power down that slot within a reasonable
> amount of time.  So there's no way that a driver could return an error
> to the remove() callback and have a chance to still be around in a
> moment or so.  And some systems (ACPI controlled PCI Hotplug), we don't
> have a choice, as the BIOS is about to do the powerdown anyway, and we
> can't stop it.

Not only that, but with Cardbus-based PCI expansion systems, a complete
PCI bus tree could have been removed and be gone before the drivers get
notified, if the user pulls the cardbus card from the slot.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


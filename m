Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbRARSAF>; Thu, 18 Jan 2001 13:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRARR7z>; Thu, 18 Jan 2001 12:59:55 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:8458 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129931AbRARR7t>; Thu, 18 Jan 2001 12:59:49 -0500
Date: Thu, 18 Jan 2001 09:59:06 -0800
To: Peter Samuelson <peter@cadcamlab.org>
Cc: James Bottomley <J.E.J.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010118095906.A8983@ferret.phonewave.net>
In-Reply-To: <mike@UDel.Edu> <200101171616.LAA01194@localhost.localdomain> <20010118065012.B26045@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010118065012.B26045@cadcamlab.org>; from peter@cadcamlab.org on Thu, Jan 18, 2001 at 06:50:12AM -0600
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 06:50:12AM -0600, Peter Samuelson wrote:
> [James Bottomley]
> > The fundamental problem that we all agree on is that SCSI devices are
> > detected in the order that the mid-layer hosts.c file calls their
> > detect routines.
> 
> That was yesterday.  Today they are detected in the order they are
> linked into the kernel, cf. the Makefile.  But yes, the problem is
> basically the same.
> 
> > Further, for multiple cards of the same type, the detection order is
> > up to the individual driver.
> 
> Yes.  PCI-based drivers will most likely use bus order since the kernel
> provides facilities to do this easily.  For a single driver driving
> multiple cards on multiple bus types, who knows.

Multiple bus types... Compaq server with PCI and EISA, for example? IIRC
the EISA bus is bridged onto one of the PCI busses. Perhaps a
breadth-first scan; PCI busses first, then bridged devices on PCI, then
internal non-PCI busses, then external busses.

Are there any systems where a non-PCI bus is not connected through a
PCI-foo bridge?

-- Ferret
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264699AbTIFAXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 20:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTIFAXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 20:23:07 -0400
Received: from lidskialf.net ([62.3.233.115]:11981 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S264699AbTIFAXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 20:23:03 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Sat, 6 Sep 2003 02:21:30 +0100
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <20030905170224.A16217@osdlab.pdx.osdl.net>
In-Reply-To: <20030905170224.A16217@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309060221.30741.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 Sep 2003 1:02 am, Chris Wright wrote:
> * Andrew de Quincey (adq_dvb@lidskialf.net) wrote:
> > On Friday 05 Sep 2003 10:35 pm, Jeff Garzik wrote:
> > > This is why we _really_ need you to split up your patches.  Multiple
> > > split-up patches, one per email, is preferred.  Don't worry about
> > > sending us too much email:  we like it like that.
> >
> > If/when I split it up, is it acceptable to number the patches to give the
> > order they have to be applied in? The major problem with these particular
> > fixes is that they all run over the same set of files, even the same
> > functions, so they all conflict with each other.
>
> Yes, please split them up.
>
> I finally narrowed down to the ChangeSet 1.1046.1.424 (ACPI: Allow irqs >
> 15...) as cause to my current hang-on-boot problem.  Quick test to see
> if this patch fixes...nope ;-(

I have reports of a number of systems with issues like this. 

I have a machine here (A Fujitsu Siemens TX150 server) in which the SCSI 
controller actually corrupts the low level format of the hard disk if I 
enable ACPI! (low level reformat required!). The ACPI IRQ setup seems to work 
fine on it (as I assume it does on your system). Its just that there seems to 
be "something else" wrong in ACPI still. Weirdly enough, it can read sector 0 
of the HDD fine.. just any reads of any other sectors cause this corruption.

Now that I've got the bulk of the changes to the basic ACPI IRQ setup done, I 
can concentrate on these issues. Can you give me details of your system and 
the following items:

successful dmesg
dmesg from a failed boot
/proc/acpi/dsdt
/proc/interrupts


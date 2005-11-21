Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVKVCop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVKVCop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVKVCop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:44:45 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:22642 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964880AbVKVCoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:44:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:Reply-To:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=T/oqkGpDI/ZX5hFL1Ap6dyZo4AEHHmLgRkoVQSRbGJqoZbNKnfPsvslWffjSmJFzxk8aEq3pZJqea4g+hXPi+cQ8/sIDixKkzUZNRiQmNnR7tfzJWN6XbCuj5klQvEPhdTB5sZxfYAlSkE+byWeuXbxt8NIcMx7zTFzy/pXMjQ8=  ;
From: Marek W <marekw1977@yahoo.com.au>
Reply-To: marekw1977@yahoo.com.au
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: SATA ICH6M problems on Sharp M4000
Date: Tue, 22 Nov 2005 10:13:04 +1100
User-Agent: KMail/1.9
Cc: Josh Litherland <josh@emperorlinux.com>, linux-kernel@vger.kernel.org,
       research@emperorlinux.com
References: <43824A6F.6070407@emperorlinux.com> <Pine.LNX.4.58.0511211438110.3900@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511211438110.3900@shark.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511221013.04798.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 09:39, Randy.Dunlap wrote:
> On Mon, 21 Nov 2005, Josh Litherland wrote:
> > Trying to get this laptop operational; it has SATA for the hard disc and
> > PATA for the optical drive.  The hard drive is wired to the secondary
> > IDE interface, the optical to the primary.  As it stands, driving the
> > whole system with the PATA (piix) driver works, but performance for the
> > hard disc is (predictably) extremely poor.  With ata_piix driving the
> > hard drive, performance is great, but the optical device is never
> > enumerated.  When the piix driver tries to load, the following occurs:
> >
> > ide0: I/O resource 0x1F0-0x1F7 not free.
> > ide0: ports already in use, skipping probe
> > ide1: I/O resource 0x170-0x177 not free.
> > ide1: ports already in use, skipping probe
> >
> > We have tried to resolve this through a wide variety of kernel command
> > line options.  Tried every combination we could think of of ide0=0x1f0,
> > ide1=0x170, ide0=noprobe, ide1=noprobe, acpi=off, noapic, lapic,
> > pci=routeirq.  Tried shaking up module load order and using ide-generic
> > instead of piix.  ahci won't bind to the device; throws error -12.
> >
> > Some information about this system including dmesg and lspci:
> >
> > http://downloads.emperorlinux.com/research/lkml/sharp_m4000/
> >
> > Thanks in advance for any advice you can give.
>
> Is there a BIOS option for SATA or AHCI modes,
> like Compatible mode or Enhanced mode?  If so, which mode
> is it in?

I have exactly the same problem with Asus W3030V which is also equipped with 
the ICH6M using the 2.6.14 kernel. There are no SATA/PATA options in BIOS for 
my laptop.

kernel options used libata.atapi_enabled=1 ide0=noprobe ide1=noprobe


-- 
-
Marek W
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+w=401wt.eu-S932113AbXAOXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbXAOXfI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbXAOXfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:35:08 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3129 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbXAOXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:35:06 -0500
Date: Tue, 16 Jan 2007 00:35:05 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: What does this scsi error mean ?
Message-ID: <20070115233504.GA63539@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	"Hack inc." <linux-kernel@vger.kernel.org>
References: <20070115171602.GA23661@dspnet.fr.eu.org> <tkrat.845391bfec80a6b0@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.845391bfec80a6b0@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 12:27:17AM +0100, Stefan Richter wrote:
> On 15 Jan, Olivier Galibert wrote:
> > sd 0:0:0:0: SCSI error: return code = 0x08000002
> > sda: Current: sense key: Hardware Error
> >     ASC=0x42 ASCQ=0x0
> 
> The Additional Sense Code means "power-on or self-test failure" FWIW.
> (SPC-4 annex D)

Given that happens between 3 days to a week after bootup on the root
drive, it's obviously not the "power on" part.  It's kinda annoying
nothing appears in the smart logs though:

smartctl version 5.36 [x86_64-redhat-linux-gnu] Copyright (C) 2002-6 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: IBM-ESXS ST936701LC    FN Version: B41D
Serial number: 3LC0C8P000007647WLMV
Device type: disk
Transport protocol: Parallel SCSI (SPI-4)
Local Time is: Tue Jan 16 00:33:09 2007 CET
Device supports SMART and is Enabled
Temperature Warning Enabled
SMART Health Status: OK

Current Drive Temperature:     33 C
Drive Trip Temperature:        60 C
Elements in grown defect list: 0
Vendor (Seagate) cache information
  Blocks sent to initiator = 16206797
  Blocks received from initiator = 83607272
  Blocks read from cache and sent to initiator = 3311410
  Number of read and write commands whose size <= segment size = 2801896
  Number of read and write commands whose size > segment size = 0
Vendor (Seagate/Hitachi) factory information
  number of hours powered up = 533.07
  number of minutes until next internal SMART test = 112

Error counter log:
           Errors Corrected by           Total   Correction     Gigabytes    Total
               ECC          rereads/    errors   algorithm      processed    uncorrected
           fast | delayed   rewrites  corrected  invocations   [10^9 bytes]  errors
read:      10474        0         0     10474      10474         61.360           0
write:         0        0         0         0          0         58.647           2

Non-medium error count:  1457822

SMART Self-test log
Num  Test              Status                 segment  LifeTime  LBA_first_err [SK ASC ASQ]
     Description                              number   (hours)
# 1  Background long   Completed                   -     407                 - [-   -    -]
# 2  Background short  Completed                   -     243                 - [-   -    -]

Long (extended) Self Test duration: 793 seconds [13.2 minutes]


  OG.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUBDSpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUBDSpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:45:45 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:41996 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S263953AbUBDSpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:45:42 -0500
Date: Wed, 4 Feb 2004 19:45:07 +0100 (CET)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@lt.wsisiz.edu.pl
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: dwmw2@infradead.org, riel@redhat.com, linux-kernel@vger.kernel.org,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <Pine.LNX.4.58L.0402041119311.1700@logos.cnet>
Message-ID: <Pine.LNX.4.58LT.0402041914510.3059@lt.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet> 
 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet> 
 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
 <1074686081.16045.141.camel@imladris.demon.co.uk>
 <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0401211809220.5874@logos.cnet> <Pine.LNX.4.58L.0401220929450.18938@logos.cnet>
 <Pine.LNX.4.58LT.0401221248560.11640@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0401221014510.18938@logos.cnet>
 <Pine.LNX.4.58LT.0401221334070.2772@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.58L.0402041119311.1700@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Marcelo Tosatti wrote:

> I wonder if this SCSI errors might have anything to do with your problem.
> I'm reluctant to revert riel's patch because it does not seem to be the
> cause for such problems --- it is pretty straighforward and no one can see
> why it would corrupt the inode list (as per dwmw2's investigation).

> When/how often do this SCSI errors messages happen ? When you saw the
> lockup, which driver were you using? (Justin's latest or 2.4.25 vanilla
> aic7xxx).

I had tested new driver 2.4-20031222 with 2.4.25-pre6 and machine had 
permanent load about 1-1,5, commands like `ps aux` or `w` was take about 10
secunds. I had also problem with reboot, it stoped on "quota turn off", 
SysRq  didn't work. On 22 Jan 2004 I have sent dump from aic79xx 
controller to gibbs@scsiguy.com

With vanilla 2.4.25-pre6 +nohighmem.patch I have'n any problems
from 12 days. No ooops, no SCSI errors. :-)
UnfortunatelyI don't know that is it hardware problem, driver problem or
something else, that's why i have sent question to LKML.


Earlier SCSI errors (2.4.24 and 2.4.24-preX kernels):

oceanic:/var/log$ zcat messages.* |grep scsi0 |grep "Bus Device"
Nov 17 19:44:26 oceanic kernel: (scsi0:A:0:0): Bus Device Reset Message Sent
Nov 17 19:44:26 oceanic kernel: scsi0: Bus Device Reset on A:0. 1 SCBs aborted
Nov  3 08:48:24 oceanic kernel: (scsi0:A:0:0): Bus Device Reset Message Sent
Nov  3 08:48:24 oceanic kernel: scsi0: Bus Device Reset on A:0. 1 SCBs aborted
Oct 29 17:21:42 oceanic kernel: (scsi0:A:0:0): Bus Device Reset Message Sent
Oct 29 17:21:42 oceanic kernel: scsi0: Bus Device Reset on A:0. 1 SCBs aborted
aborted


Tech info:

Adaptec AIC7902 Ultra320 SCSI adapter
aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs
Allocated SCBs: 96, SG List Length: 85

Disks:
SEAGATE ST373307LW (on this disk was problem) X 1
SEAGATE ST373453LW X 4


-- 
*[ £ukasz Tr±biñski ]*

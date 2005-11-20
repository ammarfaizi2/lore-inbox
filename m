Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVKUAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVKUAji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVKUAjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:39:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62337 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750944AbVKUAjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:39:14 -0500
Date: Sun, 20 Nov 2005 23:55:51 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
Message-ID: <20051120235550.GI2556@spitz.ucw.cz>
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain> <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132431907.19692.15.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19-11-05 20:25:07, Alan Cox wrote:
> On Sad, 2005-11-19 at 19:00 +0000, Alistair John Strachan wrote:
> > > SATA not yet, USB you could however.
> > 
> > Or PATA, of course. I switch off two of my HDs 4 minutes after last use with 
> > the commands:
> > 
> > hdparm -S 48 /dev/hde
> > hdparm -S 48 /dev/hdg
> > 
> > Isn't there a passthru patch in the works to let commands, such as the one 
> > required for suspend, through to a SATA device?
> 
> The latest kernels support command passthrough for SMART and the like
> but hdparm -S does not "switch off" anything. It may spin a drive down
> but the power consumption of 23 hours a day of "spun down" is
> significant, probably more than the hour it is powered up.

Really? Harddrive does not contain AC/DC converters, so situation should be slightly
better there, no?
								Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


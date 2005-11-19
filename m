Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVKSTxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKSTxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKSTxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:53:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4493 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750765AbVKSTxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:53:20 -0500
Subject: Re: Does Linux support powering down SATA drives?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511191900.12165.s0348365@sms.ed.ac.uk>
References: <437F63C1.6010507@perkel.com>
	 <1132426887.19692.11.camel@localhost.localdomain>
	 <200511191900.12165.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 20:25:07 +0000
Message-Id: <1132431907.19692.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-19 at 19:00 +0000, Alistair John Strachan wrote:
> > SATA not yet, USB you could however.
> 
> Or PATA, of course. I switch off two of my HDs 4 minutes after last use with 
> the commands:
> 
> hdparm -S 48 /dev/hde
> hdparm -S 48 /dev/hdg
> 
> Isn't there a passthru patch in the works to let commands, such as the one 
> required for suspend, through to a SATA device?

The latest kernels support command passthrough for SMART and the like
but hdparm -S does not "switch off" anything. It may spin a drive down
but the power consumption of 23 hours a day of "spun down" is
significant, probably more than the hour it is powered up.

Same as the problem with many household devices in standby that actually
end up using as lot of power in their many "turned off" hours


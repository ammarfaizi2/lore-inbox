Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVKSUVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKSUVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKSUVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:21:47 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:61620 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750797AbVKSUVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:21:46 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Does Linux support powering down SATA drives?
Date: Sat, 19 Nov 2005 20:21:40 +0000
User-Agent: KMail/1.9
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <437F63C1.6010507@perkel.com> <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain>
In-Reply-To: <1132431907.19692.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511192021.40922.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 20:25, Alan Cox wrote:
> On Sad, 2005-11-19 at 19:00 +0000, Alistair John Strachan wrote:
> > > SATA not yet, USB you could however.
> >
> > Or PATA, of course. I switch off two of my HDs 4 minutes after last use
> > with the commands:
> >
> > hdparm -S 48 /dev/hde
> > hdparm -S 48 /dev/hdg
> >
> > Isn't there a passthru patch in the works to let commands, such as the
> > one required for suspend, through to a SATA device?
>
> The latest kernels support command passthrough for SMART and the like
> but hdparm -S does not "switch off" anything. It may spin a drive down
> but the power consumption of 23 hours a day of "spun down" is
> significant, probably more than the hour it is powered up.

Interesting.

> Same as the problem with many household devices in standby that actually
> end up using as lot of power in their many "turned off" hours

My mistake, I was unaware of the difference between "Suspend" and (presumably) 
"Sleep". I've tried the latter without success on a Maxtor 120G here, does 
this work for anybody else (hdparm -Y)?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUANITX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbUANITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:19:23 -0500
Received: from dl0td.afthd.tu-darmstadt.de ([130.83.113.30]:16656 "EHLO
	dl0td.afthd.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S264382AbUANITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:19:18 -0500
From: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Message-Id: <200401140817.i0E8HBw27502@dl0td.afthd.tu-darmstadt.de>
Subject: Re: [SPAM?] [PATCH] Backport via-ircc to Linux-2.4 from 2.6
To: jt@hpl.hp.com
Date: Wed, 14 Jan 2004 09:17:11 +0100 (CET)
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       davem@redhat.com, jgarzik@pobox.com
In-Reply-To: <20040114002920.GA13260@bougret.hpl.hp.com> from "Jean Tourrilhes" at Jan 13, 2004 04:29:20 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

look, I do not have much time for this political discussion.
All I say is:

- I backported the VIA FIR IRDA driver from 2.6 because I needed it
- Most other AMD-based laptop users will need it too
- The driver (or at least a close relative) worked flawlessly for me for 1 year
- The backport does not affect other drivers or system stability even when loaded
- I am willing to maintain it till 2.4 is phased out. Which is the case when
  distros decide to go 2.6, but no earlier.

Here is the patch, take it or leave it or start talking CODE.

  -- j


> On Wed, Jan 14, 2004 at 12:42:24AM +0100, Jens David wrote:
> > Hi,
> > 
> > > On Tue, Jan 13, 2004 at 05:47:38PM -0500, Jean wrote:
> > > 
> > > 	I received very little feedback on the VIA driver (included in
> > > 2.6.X), and a few of them were negatives.
> > 
> > I used the original VIA driver for almost a year now with the original
> > Mandrake-9.1 kernel (2.4.21 based) flawlessly. This one, which is a
> > pure 1:1 copy from 2.6 with make rules etc. adjusted for about a week
> > now, flawlessly.
> 
> 	Good to know.
> 
> > > My policy has been to not backport into 2.4.X code which has
> > > not been successfully tested in 2.6.X, because 2.4.X is supposed to be
> > > stable, and up to now I don't consider the VIA driver tested. You have
> > > a few other drivers that were not backported for this exact reason.
> > 
> > Well, as a simple user (I just do kernel hacking for relaxization) I
> > must admit that I do not really understand this.
> > I would rather accept an untested or slightly flawed driver (bad
> > suspend support, busy-waits, bad coding style etc.), as long as it
> > is clearly marked "experimental", than not being able to use the device
> > at all. I suppose most users would second that. And there should be a
> > lot of them as any VIA686-based notebook with IRDA support _needs_ this
> > driver to use IRDA _at_all_. The generic SIR driver will _not_ work.
> 
> 	You probably don't understand the concept of stable and
> experimental kernel branches. Kernel 2.6.X has all the latest IrDA
> code, so if you need the VIA driver it's as easy as replacing your
> kernel with 2.6.1.
> 	So, what's your excuse for not running 2.6.1 ?
> 
> > The driver-API change is 100% backwards-compatible as it just adds
> > one primitive and does not modify the other ones. As no other driver
> > uses the new call (obviously) nothing can happen to the other drivers.
> > On the other hand it allows drop-in of other 2.6 IRDA drivers as well.
> 
> 	Yes, I must admit that it's mutch cleaner that I had feared.
> 
> >    -- jens
> 
> 	Jean
> 


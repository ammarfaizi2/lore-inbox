Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRF0QFN>; Wed, 27 Jun 2001 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRF0QFE>; Wed, 27 Jun 2001 12:05:04 -0400
Received: from marine.sonic.net ([208.201.224.37]:21104 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S263434AbRF0QEt>;
	Wed, 27 Jun 2001 12:04:49 -0400
Message-ID: <20010627090351.A7443@sonic.net>
Date: Wed, 27 Jun 2001 09:03:51 -0700
From: David Hinds <dhinds@sonic.net>
To: Andre Hedrick <andre@aslab.com>, Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org, dhinds@bolt.sonic.net
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
In-Reply-To: <3B38EE96.A6C11980@t-online.de> <Pine.LNX.4.10.10106270017350.13459-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10106270017350.13459-100000@master.linux-ide.org>; from Andre Hedrick on Wed, Jun 27, 2001 at 12:29:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 12:29:47AM -0700, Andre Hedrick wrote:
> 
> I can not help if you have a device that not compliant to the rules.
> ATA-2 is OBSOLETED thus we forced (the NCITS Standards Body) the CFA
> people to move to ATA-4 or ATA-5.
> 
> That device is enabling with its ablity to assert its device->host
> interrupt regardless of the HOST...that is a bad device.
> 
> Send me the manufacturer and I will tear them apart for making a
> non-compliant device.  Then figure out a way to de-assert the like
> regardless if it exists without hang the rest of the driver.

I don't understand the ATA spec issue, but *every* PCMCIA ATA device I
know of (including all SmartMedia, CompactFlash, etc) suffers from
this problem.  It is not an isolated manufacturer.  As far as I know,
the IDE driver has always had the problem that it may trigger
interrupts before it installs a handler.  Are you saying that is only
true of pre-ATA-4 devices, or only devices that deviate from the spec?

-- Dave


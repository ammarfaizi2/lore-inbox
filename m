Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbTHANLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTHANLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:11:49 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:55306 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269144AbTHANLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:11:48 -0400
Date: Fri, 1 Aug 2003 15:11:45 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Greg KH <greg@kroah.com>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030801131145.GA3280@win.tue.nl>
References: <3F26F009.4090608@mrs.umn.edu> <20030730231753.GB5491@kroah.com> <20030731011450.GA2772@win.tue.nl> <20030731041103.GA7668@kroah.com> <20030731005213.B7207@one-eyed-alien.net> <20030731065206.B15944@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731065206.B15944@animx.eu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 06:52:06AM -0400, Wakko Warner wrote:

> What about this one:
> Bus 001 Device 002: ID 0781:0005 SanDisk Corp. SDDR-05b (CF II) ImageMate
> CompactFlash Reader

That is reported to work with the unusual dev patch

+/* glc: Greg Corcoran <gregc at spidex.com>  -- tested with SDDR-05b */
+UNUSUAL_DEV(  0x0781, 0x0005, 0x0005, 0x0005,
+               "Sandisk",
+               "ImageMate SDDR-05b",
+               US_SC_SCSI, US_PR_ZIOCF, init_ziocf,
+               US_FL_START_STOP | US_FL_SINGLE_LUN),
+

together with the Zio! driver at sourceforge, maybe

  http://usbat2.sourceforge.net/index.html

if I recall correctly.

Andries


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUCJPBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUCJPBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:01:46 -0500
Received: from av1-2-sn3.vrr.skanova.net ([81.228.9.106]:60320 "EHLO
	av1-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262652AbUCJPA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:00:57 -0500
Subject: Re: Strange DMA-errors and system hang with Promise 20268
From: Henrik Persson <nix@syndicalist.net>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20040310123616.GA31893@darkside.22.kls.lan>
References: <1078752642.1239.14.camel@vega>
	 <Pine.GSO.4.21.0403100547430.8400-100000@dirac.phys.uwm.edu>
	 <20040310123616.GA31893@darkside.22.kls.lan>
Content-Type: multipart/mixed; boundary="=-m93JQkt/IiDdtXwn+Css"
Message-Id: <1078930851.766.7.camel@vega>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 16:00:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m93JQkt/IiDdtXwn+Css
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-03-10 at 13:36, Mario 'BitKoenig' Holbe wrote:
> On Wed, Mar 10, 2004 at 05:50:12AM -0600, Bruce Allen wrote:
> > Does the disk's SMART error log (smartctl -l error) show any entries
> > related to this problem?  If so, please print them with the latest version
> 
> No, none at all. This was the first I was looking at, because
> I just thought it was some disk problem.

Same here. Just one of the discs that has stopped during the last month
has any entries in the log at all. Those errors are attached.

The funny thing is that the machine stops responding after the
dma_timer_expiry.. Why doesn't just the kernel (or the controller for
that matter) disable DMA and then the problem would be solved, if the
problem is related to DMA, right? Sure, the speed (or lack of it) would
be painful but I wouldn't need to sit 60km from home and wondering why
my box just stopped responding. ;/

-- 
Henrik Persson <nix@syndicalist.net>

--=-m93JQkt/IiDdtXwn+Css
Content-Disposition: attachment; filename=smarterrors
Content-Type: text/plain; name=smarterrors; charset=
Content-Transfer-Encoding: 7bit

smartctl version 5.26 Copyright (C) 2002-3 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF READ SMART DATA SECTION ===
SMART Error Log Version: 1
ATA Error Count: 4
	CR = Command Register [HEX]
	FR = Features Register [HEX]
	SC = Sector Count Register [HEX]
	SN = Sector Number Register [HEX]
	CL = Cylinder Low Register [HEX]
	CH = Cylinder High Register [HEX]
	DH = Device/Head Register [HEX]
	DC = Device Command Register [HEX]
	ER = Error register [HEX]
	ST = Status register [HEX]
Timestamp = decimal seconds since the previous disk power-on.
Note: timestamp "wraps" after 2^32 msec = 49.710 days.

Error 4 occurred at disk power-on lifetime: 6619 hours
  When the command that caused the error occurred, the device was in an unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 00 00 00 e0  Error: ICRC, ABRT

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 ff 01 00 00 00 e0 08     546.992  READ DMA
  ef 03 45 20 77 a5 e0 08     546.992  SET FEATURES [Set transfer mode]
  c6 ff 10 20 77 a5 e0 08     546.992  SET MULTIPLE MODE
  10 ff 50 20 77 a5 e0 08     546.992  RECALIBRATE [OBS-4]
  91 03 3f 20 77 a5 ef 08     546.992  INITIALIZE DEVICE PARAMETERS [OBS-6]

Error 3 occurred at disk power-on lifetime: 6619 hours
  When the command that caused the error occurred, the device was in an unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 00 00 00 e0  Error: ICRC, ABRT

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 ff 01 00 00 00 e0 08     516.560  READ DMA
  ef 03 45 c5 7b e3 e0 08     516.560  SET FEATURES [Set transfer mode]
  c6 ff 10 c5 7b e3 e0 08     516.560  SET MULTIPLE MODE
  10 ff 50 c5 7b e3 e0 08     516.544  RECALIBRATE [OBS-4]
  91 03 3f c5 7b e3 ef 08     516.544  INITIALIZE DEVICE PARAMETERS [OBS-6]

Error 2 occurred at disk power-on lifetime: 6619 hours
  When the command that caused the error occurred, the device was in an unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 00 00 00 e0  Error: ICRC, ABRT

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 ff 01 00 00 00 e0 08     501.328  READ DMA
  ef 03 45 18 bb 65 e0 08     501.328  SET FEATURES [Set transfer mode]
  c6 ff 10 18 bb 65 e0 08     501.328  SET MULTIPLE MODE
  10 ff 50 18 bb 65 e0 08     501.312  RECALIBRATE [OBS-4]
  91 03 3f 18 bb 65 ef 08     501.312  INITIALIZE DEVICE PARAMETERS [OBS-6]

Error 1 occurred at disk power-on lifetime: 6619 hours
  When the command that caused the error occurred, the device was in an unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 00 00 00 e0  Error: ICRC, ABRT

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 ff 01 00 00 00 e0 08     420.528  READ DMA
  ef 03 45 73 3d 65 e0 08     412.896  SET FEATURES [Set transfer mode]
  c6 ff 10 73 3d 65 e0 08     412.896  SET MULTIPLE MODE
  10 ff 50 73 3d 65 e0 08     412.896  RECALIBRATE [OBS-4]
  91 03 3f 73 3d 65 ef 08     412.896  INITIALIZE DEVICE PARAMETERS [OBS-6]


--=-m93JQkt/IiDdtXwn+Css--


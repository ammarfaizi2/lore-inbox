Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbTAFExH>; Sun, 5 Jan 2003 23:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTAFExH>; Sun, 5 Jan 2003 23:53:07 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:779 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S266006AbTAFExG>;
	Sun, 5 Jan 2003 23:53:06 -0500
Date: Sun, 05 Jan 2003 22:00:17 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: David Lang <david.lang@digitalinsight.com>
cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Message-ID: <23180000.1041829217@aslan.scsiguy.com>
In-Reply-To: <Pine.LNX.4.44.0301052032430.25482-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0301052032430.25482-100000@dlang.diginsite.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> other then the memmap error (in my case device 0:10:0 I get the first
> three lines of the driver init and then nothing. the machine
> completely locks up (driver version on .54 is 6.2.25 but I've
> had this same problem since .50)

Some things to try:

o  Turn on the nmi_watchdog.  See the help file in the kernel Documentation
   director on how to enable it for your system.

o  Compile in the debugging code for the aic7xxx driver and turn on some
   debugging options.  Use your favorite kernel configuration utility to
   enable the debug code and use an aic7xxx command line like:

	aic7xxx=verbose.debug:0x12ff

--
Justin

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTBQPWX>; Mon, 17 Feb 2003 10:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTBQPWW>; Mon, 17 Feb 2003 10:22:22 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:4369 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S267131AbTBQPWW>;
	Mon, 17 Feb 2003 10:22:22 -0500
Date: Mon, 17 Feb 2003 08:31:32 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Shawn Starr <shawn.starr@datawire.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.61][SCSI][AIC7xxx] Problems with Tape driver
Message-ID: <348100000.1045495892@aslan.scsiguy.com>
In-Reply-To: <200302170923.50463.shawn.starr@datawire.net>
References: <200302170923.50463.shawn.starr@datawire.net>
X-Mailer: Mulberry/3.0.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While attempting to cpio extract data from the tape I got this in the logs. Is 
> this due to corrupt data on tape or the tape driver having a fit? ;-)
> 
> We are the following SCSI card and tape drive:

...

> Problems below:
> ==========
> st0: Error with sense data: Info fld=0x4, Current stst0: sense = f0  4
> ASC=40 ASCQ=81

The sense code translate into:
  Hardware Failure, Diagnostic failure: ASCQ = Component ID

In otherwords some component on the tape drive is failing diagnostics.
This is the likely cause of the other timeouts you reported.

--
Justin


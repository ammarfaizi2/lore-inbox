Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRAaKwQ>; Wed, 31 Jan 2001 05:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAaKwG>; Wed, 31 Jan 2001 05:52:06 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:36364 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129367AbRAaKvr>;
	Wed, 31 Jan 2001 05:51:47 -0500
Date: Wed, 31 Jan 2001 11:51:14 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Jurgen Botz <jurgen@botz.org>
cc: Eric Molitor <emolitor@molitor.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Wavelan IEEE driver 
In-Reply-To: <200101302222.OAA04184@nova.botz.org>
Message-ID: <Pine.LNX.4.30.0101311141170.13529-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Jurgen Botz wrote:
> and appears to work.  I did observe a problem with iwconfig dumping
> core, but it seems to do its job before it dies, so this may be non-
> critical.

Make sure you compile wireless-tools using the right headers.  You must
manually insert -I/path/to/running-linux-version/include in the Makefile.

This is due to a bad (non-existing) ioctl backward and forward
compatibility, and is being worked on.  Basically, you cannot use the
tools compiled with one version of the wireless extension headers on a
kernel with another version of the wireless extensions.  The symptom is at
best a SEGV, but you may also get strange values.

/Tobias



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

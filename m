Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRLVSdd>; Sat, 22 Dec 2001 13:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286823AbRLVSdY>; Sat, 22 Dec 2001 13:33:24 -0500
Received: from f81.law4.hotmail.com ([216.33.149.81]:5650 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S281887AbRLVSdL>;
	Sat, 22 Dec 2001 13:33:11 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Concerning a driver rewrite (NOT THE KERNEL)
Date: Sat, 22 Dec 2001 18:33:05 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F81QYrVjYKtWfN3vSAM0000e0d9@hotmail.com>
X-OriginalArrivalTime: 22 Dec 2001 18:33:05.0434 (UTC) FILETIME=[187B7FA0:01C18B17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan-
Thank you in advance Alan. I would appreciate it.
Victor

 > You driver also seems to be assuming the sound
 > driver has initialised the codec bus and codecs.) How could I fix it if 
the
 > sound codec is not initialised so that the modem codec could initialised
 > the codec bus and codecs?

As far as I can tell from a scan of the docs you need the drivers to
co-operate because if that isn't done if the modem driver inits the AC97
then it will break running audio (and vice versa). The sound driver also
has the interrupt line and status handling so that appears to need to
become shared code - or with the sound driver calling out to the modem
driver.

My i810 board doesn't have a modem or an AMR slot but I can certainly help
integrate the pieces. Right now Doug Ledford is doing major reworking on
the i810 driver (and having tried to fix audio bugs in that before I
really appreciate him taking on that battle) but after that I'm happy to
give you a hand


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.


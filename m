Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284497AbRLMSDt>; Thu, 13 Dec 2001 13:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284507AbRLMSDk>; Thu, 13 Dec 2001 13:03:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284497AbRLMSD1>; Thu, 13 Dec 2001 13:03:27 -0500
Date: Thu, 13 Dec 2001 13:02:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: Thomas Capricelli <orzel@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: Mounting a in-ROM filesystem efficiently
In-Reply-To: <06d701c183f9$08332730$5601010a@prefect>
Message-ID: <Pine.LNX.3.95.1011213125015.444A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Bradley D. LaRonde wrote:

> ----- Original Message -----
> From: "Thomas Capricelli" <orzel@kde.org>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, December 13, 2001 11:41 AM
> Subject: Re: Mounting a in-ROM filesystem efficiently
> 
> 
> > Does it mean that NONE of the existing embedded linux is able to use a ROM
> > directly as a filesystem ?? (either root fs or not)
> 

Generally, ROM based stuff is compressed before being written to
NVRAM. It's uncompressed into a RAM-Disk and the RAM-Disk is mounted.

That way, you can use, say, 2 megabytes of NVRAM to get a 10 to 20
megabyte root file-system. This also allows /tmp and /var/log to be
writable, which is a great help because the development environment 
closely approximates the run-time environment.

FYI, generally NVRAM access is sooooo slow. I don't think you'd
like to use it directly as a file-system and access-time will be
a problem unless you modify the kernel. 

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279695AbRJYHBy>; Thu, 25 Oct 2001 03:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279699AbRJYHBo>; Thu, 25 Oct 2001 03:01:44 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:5893 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279695AbRJYHBc>;
	Thu, 25 Oct 2001 03:01:32 -0400
Message-Id: <5.1.0.14.0.20011025165212.023b0ec0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Oct 2001 17:02:02 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS/Trident 4DWave sound driver oops
Cc: "Michael F. Robbins" <compumike@compumike.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1003972047.2393.9.camel@tbird.robbins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More on this kernel oops with the SiS/Trident 4DWave driver.

Went and compiled 2.4.9 and 2.4.7 without module symbol versions, and tried 
the trident module from 2.4.7 in 2.4.9. Exactly the same oops that happened 
with the 2.4.9 module, so it may not explicitly be the driver, but 
something it relies on, like the ac97_codec.

When I used insmod, it only complained about the kernel revisions, and 
nothing about symbols, so I'm guessing the interface didn't change much, if 
at all, so I used the -f option to force a load, producing an oops.

Interestingly enough, with 2.4.9. and 2.4.9 loading the 2.4.7 trident 
module, lsmod reports that while the trident driver is using ac97_codec, 
ac97_codec has 0 modules using it.

eg: (hand typed, but accurate)
  trident             24448   1  (initializing)
  soundcore            3812   1  [trident]
  ac97_codec           8864   0  [trident]

Hope this helps.

AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSEXQpn>; Fri, 24 May 2002 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSEXQpm>; Fri, 24 May 2002 12:45:42 -0400
Received: from ns.caldera.de ([212.34.180.1]:57820 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S314475AbSEXQpm>;
	Fri, 24 May 2002 12:45:42 -0400
Date: Fri, 24 May 2002 18:45:37 +0200
Message-Id: <200205241645.g4OGjbE30934@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.2.19 with -O3 flag
In-Reply-To: <1022253543.962.236.camel@sinai>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1022253543.962.236.camel@sinai> you wrote:
> On Fri, 2002-05-24 at 07:42, Alan Cox wrote:

>> Bench it and see. From my own experience -O3 made the kernel a lot larger
>> and reduced overall performance - in part because the kernel already 
>> explicitly figures out what it wants inlined.
>> 
>> Interestingly enough -Os outperformed -O2

> Heh, now that is interesting.

Not really, -Os implies -O2, cf gcc/toplev.c:

          if ((p[0] == 's') && (p[1] == 0))
            { 
              optimize_size = 1;

              /* Optimizing for size forces optimize to be 2.  */
              optimize = 2;
            }

CIao, Marcus

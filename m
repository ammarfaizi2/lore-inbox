Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135721AbRDXTQi>; Tue, 24 Apr 2001 15:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135722AbRDXTQ2>; Tue, 24 Apr 2001 15:16:28 -0400
Received: from smtp7.xs4all.nl ([194.109.127.133]:47340 "EHLO smtp7.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135721AbRDXTQS>;
	Tue, 24 Apr 2001 15:16:18 -0400
From: thunder7@xs4all.nl
Date: Tue, 24 Apr 2001 20:30:14 +0200
To: Andy Carlson <naclos@swbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: Matrox FB console driver
Message-ID: <20010424203014.A6397@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.10.10104232117410.30211-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.20.0104240616170.244-100000@bigandy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.20.0104240616170.244-100000@bigandy>; from naclos@swbell.net on Tue, Apr 24, 2001 at 06:19:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 06:19:31AM -0500, Andy Carlson wrote:
> time prime before x
> real    1m23.535s
> user    0m40.550s
> sys     0m42.980s
> 
> /proc/mtrr before x
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0xfd800000 (4056MB), size=   4MB: write-combining, count=1
> 
> time prime after x
> real    0m48.732s
> user    0m41.070s
> sys     0m7.690s
> 
> /proc/mtrr after x
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0xfd800000 (4056MB), size=   4MB: write-combining, count=1
> 
> time prime in X
> real    0m42.835s
> user    0m41.180s
> sys     0m1.710s
> 
Well, it isn't that.
Still, it was recently discussed that X might leave some settings in the
video-card (Matrox).

So I tried the following:

time spdtest.sh before X with spdtest.sh:

#!/bin/sh
i=1
while [ $i -lt 500 ]
do
   clear
   echo $i
   cat test.out;
   i=`expr $i + 1`
done

and after X, no change.
This is a G400/32 Mb with framebuffer @ 1600x1200x16bpp, and X 4.0.3,
same resolution. Kernel 2.4.3-ac12, Abit VP6 dual P3/866.

There was no significant change in any of the reported times.

I don't know. Your problem is interesting. Do other programs have this
too?

Jurriaan
-- 
And the gosts of hope walk silent halls
At the death of the promised land
All is gone, all is gone
But these changing winds can turn cold and hostile
	New Model Army
GNU/Linux 2.4.3-ac12 SMP/ReiserFS 2x1743 bogomips load av: 0.00 0.03 0.01

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280627AbRKYBpL>; Sat, 24 Nov 2001 20:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280646AbRKYBov>; Sat, 24 Nov 2001 20:44:51 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:4680 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S280641AbRKYBoq>; Sat, 24 Nov 2001 20:44:46 -0500
Date: Sun, 25 Nov 2001 02:44:31 +0100
From: Sven.Riedel@tu-clausthal.de
To: Phil Howard <phil-linux-kernel@ipal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011125024431.A26191@moog.heim1.tu-clausthal.de>
In-Reply-To: <20011124174134.B4372@vega.ipal.net> <200111250024.AAA10086@mauve.demon.co.uk> <20011124185321.C4372@vega.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011124185321.C4372@vega.ipal.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 06:53:21PM -0600, Phil Howard wrote:
> If it takes 1 second to spin down to a stop, the it probably will
> have slowed to a point where serialization writing a sector cannot
> be kept in sync within 1 to 5 milliseconds.  Once they _start_
> slowing down, time is an extremely precious resource.  That data
> pattern has to be read back at full speed.

Makes you wonder why drive manufacturers don't use some kind of NVRAM to 
simply remember the sectornumber that is being written as power fails - 
a capacitor, or even a small rechargeable battery (for the truely
paranoid), could supply the writing voltage. No (further) writing to the 
sector would be needed during spindown. And when the drive initializes 
again at boottime, it could check to see if the contents of the NVRAM is
not an "all OK" pattern, and simply rewrite the CRC of the sector in
question, unless that sector is already present in the bad-sector list
of the drive. 
Yes, this would be a bit more complex, and presents one more possible
point of failure, but the current situation seems rather abysmal...
And the data in that sector is as good as lost, anyway.

Regs,
Sven
-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 

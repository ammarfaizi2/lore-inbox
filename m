Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130018AbRBEXxR>; Mon, 5 Feb 2001 18:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135951AbRBEXxH>; Mon, 5 Feb 2001 18:53:07 -0500
Received: from mail09.voicenet.com ([207.103.0.35]:52162 "HELO
	mail09.voicenet.com") by vger.kernel.org with SMTP
	id <S130018AbRBEXw7>; Mon, 5 Feb 2001 18:52:59 -0500
Message-ID: <3A7F3CD7.620AF808@voicenet.com>
Date: Mon, 05 Feb 2001 18:52:55 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/meminfo displays incorrect memory sizes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I personally have no way of knowing if it's giving incorrect numbers for
cache and buffers and used and such ..  but as for total memory,
something is wrong.  lm sensors tells me i have 288MB of ram, the bootup
messages say i have 288MB of memory with 4MB being used by the kernel
and my bios says i have 288MB.   /proc/meminfo, however, says i have
@167MB.  Is this  correct?  and why ?
i'm using 2.2.19-pre7   I have agpgart and mtrr compiled in

< from dmesg >
Memory: 290412k/294848k available (864k kernel code, 412k reserved,
3112k data, 48k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 232M
agpgart: Detected Via Apollo KX133 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
bttv: driver version 0.7.54 loaded
bttv: using 8 buffers with 2080k (16640k total) for
capture                     that adds to  31.148MB  (used)

@288MB full    @284MB useable

< from sensors >
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        128

eeprom-i2c-2-51
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        64

eeprom-i2c-2-52
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        64

eeprom-i2c-2-53
Adapter: SMBus vt82c596 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):
32                                                   that adds to 288


 </proc/meminfo >
        total:    used:    free:  shared: buffers:  cached:
Mem:  280281088 276422656  3858432 86532096 69550080 108240896
Swap: 139821056        0 139821056
MemTotal:    273712 kB
MemFree:       3768 kB
MemShared:    84504 kB
Buffers:      67920 kB
Cached:      105704 kB
SwapTotal:   136544 kB
SwapFree:    136544 kB


that is about  267MB total



anyone?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271909AbRH2FjR>; Wed, 29 Aug 2001 01:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271910AbRH2FjH>; Wed, 29 Aug 2001 01:39:07 -0400
Received: from snoopy.apana.org.au ([202.12.87.129]:35333 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S271909AbRH2FjE>; Wed, 29 Aug 2001 01:39:04 -0400
To: linux-kernel@vger.kernel.org
Subject: USB flash card reader
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 29 Aug 2001 15:38:48 +1000
Message-ID: <847kvn4e8n.fsf@scrooge.chocbit.org.au>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a usb-storage.o USB device, that to /proc/bus/usb/devices looks
like this:

T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=02 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0781 ProdID=0001 Rev= 2.00
S:  Manufacturer=SanDisk Corporation
S:  Product=SanDisk USB ImageMate
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=usb-storage
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

When "mount /dev/camera" has been entered, the first time it complains
that it can't find the device (something funny with hotplug here). So
I unplug the USB device and plug it back in again.  This is normal.

Now, the same mount command in entered, the process hangs in kernel
mode (so kill -9 will not work). Furthermore, the computer hangs when
shutting down, making a clean shutdown impossible. (Or perhaps I am
just being too impatient and not waiting longer enough for something
to timeout?)

Only problem is that when I go to reproduce this problem with/without
strace, it works!

As far as I know the only potentially serious mistakes the user could
make are unplugging the USB device or removing the flash card when it
is mounted, but as far as I am aware, neither of those cases apply
here.

Any ideas?

Only problem is that I have been telling others how reliable and
robust Linux is, but what does it do, but crash! Argghh!
-- 
Brian May <bam@snoopy.apana.org.au>

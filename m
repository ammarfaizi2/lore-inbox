Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280633AbRKFW1i>; Tue, 6 Nov 2001 17:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280630AbRKFW1T>; Tue, 6 Nov 2001 17:27:19 -0500
Received: from adsl-216-102-162-162.dsl.snfc21.pacbell.net ([216.102.162.162]:19638
	"EHLO janus") by vger.kernel.org with ESMTP id <S280625AbRKFW1O>;
	Tue, 6 Nov 2001 17:27:14 -0500
Message-ID: <3BE870EF.2080508@gutschke.com>
Date: Wed, 07 Nov 2001 00:23:27 +0100
From: Stephan Gutschke <stephan@gutschke.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there you go,  the output from  /proc/bus/usb/devices
By the way I have an Clie N710C which is upgraded
to an 760 with OS 4.1S, shouldnt make a difference,
but I just wanted to let you know.


T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=1060
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS=16 #Cfgs=  1
P:  Vendor=054c ProdID=0066 Rev= 1.00
S:  Manufacturer=Sony Corp.
S:  Product=Palm Handheld
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=serial
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms


Greg KH wrote:

>On Tue, Nov 06, 2001 at 03:27:46PM +0100, Stephan Gutschke wrote:
>
>>Hi Greg,
>>
>>the output is below, I also added a couple of debug-lines in the
>>visor_open() function. Seems to me like port->read_urb is null and
>>maybe that shouldn't be?
>>
>
>Hm, yes, port->read_urb should _NOT_ be NULL.  Thanks for adding this
>check.
>
>Can you send the output of /proc/bus/usb/devices right after you press
>the sync button on the Clie?  Don't try syncing :)
>
>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Stephan Gutschke




Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313174AbSEMOwD>; Mon, 13 May 2002 10:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313217AbSEMOwC>; Mon, 13 May 2002 10:52:02 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:44559
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S313174AbSEMOwB>; Mon, 13 May 2002 10:52:01 -0400
Message-ID: <3CDFD301.6050107@inet6.fr>
Date: Mon, 13 May 2002 16:51:45 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre LeBlanc <ap.leblanc@shaw.ca>
CC: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: More UDMA Troubles
In-Reply-To: <003f01c1fa36$0106ded0$2000a8c0@metalbox> <20020513095630.A25699@bouton.inet6-interne.fr> <001801c1faa0$fcb7cd60$2000a8c0@metalbox>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre LeBlanc wrote:

>Andre: This occured on 2.5.15 but I also had similar errors with 2.4.18, and
>the default kernel thats installed with debian woody (I think its 2.2.17,
>not sure though),  but the system still booted, it just did strange things
>afterwards and eventually locked up. the 2.2.17 worked fine until I did
>hdparm -c3 -d1 -X34.
>
>Lionel: I don't want to sound like an idiot or anything but I have no idea
>how to install 2.4.19-pre8, it looks like some kind of patch, but i've never
>used one before.
>
 From memory :

go to http://www.kernel.org/
1/ get linux-2.4.18.tar.gz as you probably did for 2.5.15.
2/ before configuring the kernel sources:
- get patch-2.4.19-pre8.gz,
- apply the patch by:
    . going into the 2.4.18 source directory,
    . running zcat <path_to_download_dir>/patch-2.4.19-pre8.gz | patch -p1
3/ configure, compile, install.

>
>I think that running that, hdparm command may have actually done some damage
>to my computer... since then my BIOS Occasionally doesn't recognize my hard
>drive, and Windows 2000 keeps getting bluescreens during the boot process,
>it took 4 tries to get it to boot properly, and I ahve a feeling it will
>lock up eventually. (I've never had a bluescreen uder 2000 before.)
>  
>

Strange.
I've a similar problem here with an ECS K7S5AL where one of the 4 IDE 
devices seems to transmit bad data on a "cold" boot, this drive's id is 
usually "Maxtor 4G120J6" but on a cold boot the BIOS see everytime a L 
instead of a M in "Maxtor" and other characters are shifted 
(--ascii_value or maybe low bit of ascii_value zeroed, didn't check) at 
regular intervals. The whole data on the disk seems to be affected as 
Linux can't mount the only fs on the drive. I moved the disk from hdc to 
hdd and then to hdb and each time it behaves like described above.
Updating the BIOS doesn't solve the problem. The only workaround is to 
wait several minutes for the system to warm up.
After warm up I *never* encoutered a crash with 2.4.19-pre7-ac2 which 
holds the very same SiS IDE driver than 2.4.19-pre8 (at least 14 days 
uptime doing regular video grabbing on another disk and occasionnal huge 
file transfers between the Maxtor and other disks).

In my case the problem must be the drive firmware or the hardware 
itself. This may be the same problem for you. Do you have another drive 
to make tests with ? When your BIOS doesn't recognise your drive, what's 
the error ? When the BIOS recognise it and Windows bluescreens, what's 
the drive ID reported by the BIOS ?

You didn't tell us what your mainboard model is, could you please do so 
and tell us the harddrive model (hdparm -i) ?

LB.



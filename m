Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRAEAMb>; Thu, 4 Jan 2001 19:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRAEAMV>; Thu, 4 Jan 2001 19:12:21 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:27022 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129563AbRAEAMH>;
	Thu, 4 Jan 2001 19:12:07 -0500
Message-ID: <3A551155.1060001@voicefx.com>
Date: Thu, 04 Jan 2001 19:12:05 -0500
From: "John O'Donnell" <johnod@voicefx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-prerelease-ac4 i686; en-US; m18) Gecko/20010103
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops 2.2.17 and 2.0.37pre10 - same machine
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to install Slackware Linux.
I boot the 2.2.17 from slackware-current series
I fdisk /dev/hda1 as 128MB Swap and /dev/hda2 as root.
I run mkswap -c -v1 /dev/hda1 - it chugs and finishes...
I run swapon /dev/hda1 and I get an oops!

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
Current->tss.cr3 = 07737000, %cr3 = 07737000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010[<c0126794>]
EFLAGS: 00010202
eax: c7ffd5e0  ebx: 00000000  ecx: c6980801  edx: 00000000
esi: 00016fc4  edi: 00000000  ebp: 00000000  esp: c7739efc
ds: 018  es: 0018  ss: 0018
Process swapon (pid: 88, process nr: 13, stackpage=c7739000)
Stack: c7731140 00000000 00000801 00000000 0801ffff c0123771 00000801 00001000
        c7738000 bffffd7c 08049106 ffffffff 00000000 0000009d 0c7feb32 c7739f88
        00000000 c7647009 c02abac0 c776aee0 00000801 00001140 c7739f68 00000000
Call Trace: [<c0123771>] [<c0109158>]
Code: 8b 6b 1c 66 86 4c 24 1a 66 39 4b 0c 0f 85 c3 00 00 00 8b 4c
Segmentation fault
#

This is a brand new machine.
PIII 800 (133Mhz bus)
Acorp 6BX/VIA83
128Mb RAM

I thought it might have something to do with the IDE drive or controller.
I installed a trusty Adaptec 2940AU and a Seagate 4G drive.  Same thing?!?!
So it is not the drives or controllers...
For kicks I put in a Slackware 3.9 (kernel 2.0.37pre10) cd I had next to me.
Boot.   fdisk - partitions ok.
mkswap -c -v0 /dev/sda1
Oops.....

Can anyone help me?  I have scoured the BIOS for any flaky settings.
I can see none.  HHHHhhhhheeeeelllllpppppp.....  :-)
Johnny O

-- 
<SomeLamer> what's the difference between chattr and chmod?
<SomeGuru> SomeLamer: man chattr > 1; man chmod > 2; diff -u 1 2 | less
	-- Seen on #linux on irc
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell (Sr. Systems Engineer, Net Admin, Webmaster, etc.) |
| Voice FX Corporation (a subsidiary of Student Advantage)          |
| One Plymouth Meeting         |     E-Mail: johnod@voicefx.com     |
| Suite 610                    |           www.voicefx.com          |
| Plymouth Meeting, PA 19462   |         www.campusdirect.com       |
+==============================+====================================+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282343AbRK2DoP>; Wed, 28 Nov 2001 22:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282353AbRK2DoF>; Wed, 28 Nov 2001 22:44:05 -0500
Received: from mail.iis.com.br ([200.202.96.2]:4266 "EHLO home.iis.com.br")
	by vger.kernel.org with ESMTP id <S282350AbRK2Dn4>;
	Wed, 28 Nov 2001 22:43:56 -0500
Message-ID: <3C05AEAF.2050402@iis.com.br>
Date: Thu, 29 Nov 2001 01:42:39 -0200
From: Osvaldo Marques Junior <dis@iis.com.br>
Organization: dis
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.16 i686; en-US; rv:0.9.1) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ide /dev/hda turned off during intensive write on /dev/hdc using kernel 2.4.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: Antivirus for sendmail by Petr Rehor
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlemen,

I,m using 2.4 kernels since 2.4.0. Very often, in a system with more
than one hard disk, the first drive shuts off while the kernel is still
running.
In a configuration where I had a Seagate ST320413A (20GB) as /dev/hda
and an ancient scsi seagate ST52160N (2GB) as the second drive
(/dev/sda), just for data backup, running on an AMD500 64MB, my 
suspicion went to the drive and I started to work with the PC without 
case. When the drive stoped, I would unplug the power conector from it, 
plug it again and the system would recover without any problem. When I 
bought a new drive, I got a 40GB and then I didn't need the scsi, so the 
problem was apparently solved.

Now, I am configuring a Pentium III (Coppermine) 1GHz with 512MB memory
and I return to use 2 disks, now both IDE, one QUANTUM FIREBALLct20
(20GB) as /dev/hda and the same Seagate ST320413A (20GB) removed from
the other machine.
I have to say this two disks are "my laptop" since I carry them in my
suitcase for use at home, bring them to the office and to my customers
any time I need to do a local assistance.
I started suspecting of the Pentium III when doing an "rsync copy" from
the other machine ("the prime suspect"). It was a copy of a 3GB
partition for backup purposes to the /dev/hdcx, throw a 10Mb coaxial 
lan. One of each 3 copies put the /dev/hda off. I could hear the noise 
of the heads being moved to the safe position. The "rsync" continued to 
the end, but I had no way to do any command, even halt, shutdown or
Ctrl/Alt/Del. All the commands got "command not found". I ran like a
crazy behind the Ext3 patches, because after a power down, it means 40GB
of fsck.
My suspicion were to the machine, because I have forgotten the first
problem here reported and with this same disks, my "home pc", an AMD 500
with 128MB ran smoothly. Until last week end! This week end I altered
the configuration of my home pc, which I used to put this disks as
/dev/hda and /dev/hdb to the same assembly of the office, /dev/hda and
/dev/hdc. When I started to compile the 2.4.16-pre1, with the sources on
the /dev/hdc, the problem happened at home.
On monday, I changed the PIII by another with the same configuration and
the problem still happens.
Today I got 3 occurencies, simply copying the root partition to a
partition in the second disk using a couple of piped cpio's.
The difference between the first configuration, where I suspect from the
drive and the last is: I can't recover from the problem, unplugging the
drive and plugging it again.

Please, excuse my syntax mistakes, the lack of more specific info and 
guide me to collect more data to solve this problem.

Many thanks in advance,

Osvaldo.



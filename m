Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSEaSxY>; Fri, 31 May 2002 14:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSEaSxX>; Fri, 31 May 2002 14:53:23 -0400
Received: from linuxpc1.lauterbach.com ([213.70.137.66]:45485 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S316589AbSEaSxW>; Fri, 31 May 2002 14:53:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: [PATCH] Artop update
Date: Fri, 31 May 2002 20:55:30 +0200
User-Agent: KMail/1.4.1
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
In-Reply-To: <200205311951.35809@enzo.bigblue.local> <3CF7B339.3000406@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205312055.30660@enzo.bigblue.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 May 2002 19:30, Martin Dalecki wrote:
> Franz Sirl wrote:
> > The hunk to main.c is needed to be able to boot with DEVFS enabled.
>
> Better just don't do devfs :-). But anyway...

I like it :-)

> Well I'm planing to add kernel version tagging of fstab line enties
> to util-linux. This seems to be the only way to make major/minor
> transitions (and the more I think about it the more I'm convinced
> that they will be unevitable at some not so distant point in time!)
>
> Something along the lines of:
>
> cat /etc/fstab:
>
> /dev/hdc                /                       ext3    v2.4,defaults    1
> 1 /dev/sda1
>          /                       ext3    v2.5,defaults    1 1
> LABEL=/boot             /boot                   ext3    defaults        1 2
> /dev/fd0                /mnt/floppy             auto    noauto,owner    0 0
> # /dev/loop1            /mnt/1                  auto    noauto,owner    0 0
> # /dev/loop2            /mnt/2                  auto    noauto,owner    0 0
> none                    /proc                   proc    defaults        0 0
> none                    /tmp                    tmpfs   defaults        0 0
> none                    /dev/pts                devpts  gid=5,mode=620  0 0
> /dev/hda6               swap                    swap    defaults        0 0
>
>
> Would be *very* convenient for this purpose and solve 99.9999% percent
> of portability problems. Well the above syntax may be the esiest to
> imeplement however the below syntax would be perhaps more palatable:
>
> 2.5:/dev/sda1
> 		/		ext3 ....
>
> Opinnions?

Well, the only time I would need something like that is for label/id-less 
stuff, with swap being the most annyoing one for me.

> perhaps a similar adjustments would be required for the kernel root
> parameter of course.

Actually I would love to see something like root=LABEL:root_rh_on_40G on the 
commandline.

Franz.


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSECMuh>; Fri, 3 May 2002 08:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSECMug>; Fri, 3 May 2002 08:50:36 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:4876 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S311749AbSECMuf>; Fri, 3 May 2002 08:50:35 -0400
Message-ID: <3CD2875C.439AC914@aitel.hist.no>
Date: Fri, 03 May 2002 14:49:32 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.12-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au> <5.1.0.14.2.20020502094535.04261b70@pop.cus.cam.ac.uk> <200205030931.g439VEX09418@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 2 May 2002 06:49, Anton Altaparmakov wrote:
> > >And I recently moved my /usr/src to separate partition.
> > >That is, /usr/src is now a mount point.
> > >I have to export it in NFS exports *and* mount it *on every workstation*
> > >(potentially thousands of wks!).
> >
> > Yes, edit /etc/fstab. My file server has loads of partitions and it exports
> > them all and /etc/fstab on all clients just mounts them all. Problem being?
> 
> Problem is that I have to modify /etc/fstab on every workstation.
> 
So _automate_ that then.  If you have so many workstations, make
a program/script that fix /etc/fstab.  Perhaps as simple as appending
a new line with the new fs to mount.  Put the program one some fs
already mounted on the clients, then ssh to each and run it.
The ssh part may be automated too, of course.

[...]
> It seems to me like the Bad Thing which is too old and traditional to change.
> :-(

Most ways have their own disadvantages.  Can you invent a better concept
than the inode that works as well in every existing way, and better for
this case?  Your new syscall isn't it, as Pavel Machek demonstrated.

Changing unix is doable _if_ you can show a significant benefit.
The more utilities you want to break, the more benefit you need to show.
I don't think you can send the inode to the land of 
"8-char limited passwords" by pushing "simpler management of fstabs"
though.

Helge Hafting

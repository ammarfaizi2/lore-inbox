Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280875AbRKTDri>; Mon, 19 Nov 2001 22:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280878AbRKTDrZ>; Mon, 19 Nov 2001 22:47:25 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:63236
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S280875AbRKTDrR>; Mon, 19 Nov 2001 22:47:17 -0500
Date: Mon, 19 Nov 2001 19:46:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Gernot.Fink" <Gernot.Fink@netsurf.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux can use a mountpoint for 2 Filesystems
In-Reply-To: <Pine.LNX.4.10.10111191938450.12291-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10111191939290.12141-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings Gernot,

You can do this with all real and virtual spindles under Linux.
The reality is total crap that it can happen, but what the hey ...
No policies in UNIX, ROOT beware.

Sorry, but this report saddens me, issues like these are permitted
There are no kernel controls to prevent multi mounting to the same point.

Regards,

Andre Hedrick
Linux ATA Development

On Tue, 13 Nov 2001, Gernot.Fink wrote:

> Hallo,
> 
> I dont know if this is a kernelbug, but I can mount 2 Filesystems to a
> mountpoint.
> 
> like
> mount /dev/hda6 /mnt
> mount /dev/hda7 /mnt
> 
> after the second mount is /dev/hda7 mounted.
> 
> Strace says that the mount-systemcall returns 0
> 
> 
> This is the output from mount
> 
> /dev/hda5 on / type ext2 (rw)
> proc on /proc type proc (rw)
> /dev/hda1 on /dos type msdos (rw,gid=45,umask=2,quiet)
> devpts on /dev/pts type devpts (rw,gid=5,mode=0620)
> /dev/hda6 on /mnt type ext2 (rw)
> /dev/hda7 on /mnt type minix (rw)
> 
> Thanks for your great work.
> 
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux gar 2.4.14 #11 Wed Nov 7 21:15:48 MET 2001 i686 unknown
> 
> Gnu C                  2.95.2
> Gnu make               3.77
> binutils               2.9.1.0.25
> util-linux             2.10o
> mount                  2.10o
> modutils               2.4.0
> e2fsprogs              1.19
> pcmcia-cs              3.0.4
> PPP                    2.4.1
> Linux C Library        2.1.2
> Dynamic linker (ldd)   2.1.1
> Procps                 1.2.11
> Net-tools              1.52
> Kbd                    0.99
> Sh-utils               1.16
> Modules Loaded         minix slip 8139too msdos fat
> 
> 
> --
> MFG Gernot
> 


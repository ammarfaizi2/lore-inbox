Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSCRPhQ>; Mon, 18 Mar 2002 10:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSCRPhH>; Mon, 18 Mar 2002 10:37:07 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57566 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287858AbSCRPhC>; Mon, 18 Mar 2002 10:37:02 -0500
Date: Mon, 18 Mar 2002 08:36:37 -0700
Message-Id: <200203181536.g2IFabF18869@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Felix Braun <Felix.Braun@mail.McGill.ca>, linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
In-Reply-To: <200203180639.g2I6dVq27119@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:
> On 17 March 2002 09:19, Felix Braun wrote:
> > Hi Richard,
> >
> > I just noticed that devfs is listed twice in /proc/mounts in linux
> > 2.4.19-pre3, which confuses my shutdown script. Under 2.4.19-pre my
> > /proc/mounts looks like this:
> >
> > devfs /dev devfs rw 0 0
> > /dev/ide/host0/bus0/target0/lun0/part5 / reiserfs rw 0 0
> > none /dev devfs rw 0 0
> > /proc /proc proc rw 0 0
> > /dev/discs/disc0/part1 /dos vfat rw 0 0
> > /dev/discs/disc0/part9 /opt reiserfs rw,noatime 0 0
> > none /dev/pts devpts rw 0 0
> > /dev/discs/disc0/part7 /usr reiserfs rw 0 0
> > none /dev/shm tmpfs rw 0 0
> >
> > whereas under 2.4.18 the first line didn't show up. Is that a
> > misconfiguration on my part?
> 
> Maybe you mount devfs manually after kernel did the same?
> devfs /dev devfs rw 0 0 - most probably mounted by initscripts
> none /dev devfs rw 0 0 - by kernel
> 
> Look into /var/log/messages for:
> kernel: VFS: Mounted root (nfs filesystem).
> kernel: Mounted devfs on /dev   <============ do yo have this?

No, I don't think that's the problem. I now also have two devfs
entries in /proc/mounts with 2.4.19-pre3. My boot scripts don't mount
devfs. I'm looking into the problem. It seems to have something to do
with Al's changes to the boot sequence code.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

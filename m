Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSFVPlR>; Sat, 22 Jun 2002 11:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSFVPlQ>; Sat, 22 Jun 2002 11:41:16 -0400
Received: from pop.gmx.net ([213.165.64.20]:16241 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315971AbSFVPlP>;
	Sat, 22 Jun 2002 11:41:15 -0400
Message-ID: <3D149A8E.E714A1B4@gmx.net>
Date: Sat, 22 Jun 2002 17:41:02 +0200
From: Richard Ems <r.ems.home@gmx.net>
Reply-To: r.ems@gmx.net
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,de,es
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Hubert Mantel <mantel@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: kernel OOPS: 2.4.18, nscd, nfsd
References: <3D104DF4.A8053F67@gmx.net> <15634.50708.164289.246414@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Neil Brown wrote:

> On Wednesday June 19, r.ems.home@gmx.net wrote:
> > Hi all!
> >
> > Two kernel Oopses in short time (22:35:59 and 22:50:00). But the computer was still alive until 00:00:00, where the daily cron jobs are started and then ... kernel panic, LED's where blinking   :(
> >
> > kernel is 2.4.18, from SuSE's k_deflt-2.4.18-174 package (2.4.19-pre10aa2)
> >
> > Please CC to r.ems@gmx.net, I'm not on the linux-kernel mailing
> > list.
>
> Would I be right is surmising that you are exporting an ISO filesystem
> over NFS??  That would be the second Oops in as many days with that
> scenario.
>
> If that is the case, then I'm afraid that I cannot point you to any
> fix, though exporting with "no_subtree_check" may reduce the incidence.
>
> NeilBrown

No, no ISO fs exported.

My /etc/exports:

# cat /etc/exports
/home \
 diablo(rw,no_root_squash) @linux(rw,root_squash) @unix(rw,root_squash) mtgvaio1(ro,root_squash) @cluster01_hosts(rw,root_squash)
/tmp \
 diablo(rw,no_root_squash) @linux(rw,root_squash) @unix(ro,root_squash) mtgvaio1(ro,root_squash) @cluster01_hosts(rw,root_squash)
/usr/local \
 diablo(ro,no_root_squash) @linux(ro,root_squash) @unix(ro,root_squash) mtgvaio1(ro,root_squash) @cluster01_hosts(ro,root_squash)

and

# egrep " /home | /tmp | /usr " /proc/mounts
/dev/vg01/home /home ext3 rw 0 0
/dev/vg01/tmp /tmp ext3 rw 0 0
/dev/vg01/usr /usr ext3 rw 0 0

all exported filesystems are ext3 over LVM.

(I stopped a while ago exporting ISO fs's over nfs, I'm now copying the distro DVD (SuSE) on a HD ... Any "good" solution for exporting ISO fs's over NFS ? the problem is always when you need the
cdrom/dvd drive and want to umount the NFS exported cdrom/dvd, then ...)

What about the first Oops ?

Thanks, Richard



--
Richard Ems
... e-mail: r.ems@gmx.net
... Computer Science, University of Hamburg

Unix IS user friendly. It's just selective about who its friends are.



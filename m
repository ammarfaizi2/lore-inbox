Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131719AbRAQJqG>; Wed, 17 Jan 2001 04:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131620AbRAQJp4>; Wed, 17 Jan 2001 04:45:56 -0500
Received: from ip165-168.fli-ykh.psinet.ne.jp ([210.129.165.168]:29379 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131552AbRAQJpw>;
	Wed, 17 Jan 2001 04:45:52 -0500
Message-ID: <3A6569AF.63743C3B@yk.rim.or.jp>
Date: Wed, 17 Jan 2001 18:45:20 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Michael Meissner <meissner@spectacle-pond.org>,
        "'linux-scsi @ vger . kernel . org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org> <20010117003205.A711@werewolf.able.es>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:

>
>
> Average users you are targetting with that automagical
> card detection even do not know there are SCSI and IDE disks. They just
> want a 30Gb ide disk to install linux and play. If they involve with SCSI
> and ID numbers and multiple cards and so on they can read some docs and
> rebuild a kernel.

Like Michael Meissner, I have been using Unix-like systems
since it first came to Japan around 1981 : the first one was
on a VAX at a university computer centre. (Its official English
name was spelled with centre.)

I came to use Linux after I bought Yggdrasil Fall 1994 disk.
I began using it regularly for the last two or three years
(after OS/2).

Anyway, I view myself a typical Linux end-user in
the framework of linux system hacker, linux
tools developer and the rest (user).
All I do on my PC is run netscape, read e-mails,
post news articles, run editor to edit documents,
and compile a few utilities and such (for
using openssh).

And maybe I occasionally produce patches when I notice
a few problems in these utilities and send them
to the original writers or the current maintainers.
(The average users that J.A. Magallon have in mind
may not produce patches, but I am not sure.)


Granted I probably have more general knowledge of computers,
(administered and used Data General MV [:-)], DEC, HP, Sun, ...]
than average users,
but then I was totally confused about the
recognition order of SCSI devices under Linux when I
had the second SCSI adaptor in my PC.
As a matter of fact, I hit on a dormant bug/feature
in the SCSI subsystem and was helpless until
I wrote to Kurt Garloff(DC390(tmscsim) maintainer).

There was not much documentation to rely on then.
Is there enough, today? I wonder.

It is true that with 2.4.x kernel:
 ...................................................
- we can control the recognition order of different
  brand of SCSI cards using scsihosts kernel parameter.
  (Don't know if this works under non-x86 platforms.)
  I use loadlin and scsihosts does work.

- we can possibly control the recognition order of
  the same brand of cards either by
   - the driver (module) parameter if the driver supports
     it, or
   - by swapping the bus slots of the drivers (sometimes),
   - or probably swapping the cable if all the devices
     are external to the box (if appropriate).
 ...................................................
These might be documented somewhere, but I am not sure.
Maybe the config script or rather the short help message
that appears might want to mention this somewhere.

Then there is the naming scheme:

As noted recently, the name of the devices
shift if we add, say, a disk in the SCSI chain.

By going to `devfs', I am told that the naming becomes
consistent, but unfortunately, I have not
yet figured out how to write the initializing devfs
script for my Debian GNU/Linux system yet.
(Yes, I went to R. Gooch home page and started to
read the howto doc there, but I am not entire sure of
the way initializing script under /etc/rc" ought to be
written for my Debian GNU/Linux : rather than risking
my system's health, I have given up  and hoping that
Debian distribution will have devfs as part of standard
installation soon.)

Anyway, from the viewpoint of Linux (end) users,

 - there is not much in the way of documentation.
   I wonder if the SCSI-HOWTO is ever updated these days.

 - Read the source also doesn't work very well
   even if the user does read C source code with
   15+ years of C programming (from my own experience)
   SCSI subsystem is rather hard to read.
   It is a good thing that Alan Cox did the
   major surgery of re-formatting the code
   during 2.3.xx development.

My point is that SCSI subsystem under Linux is
not very user-friendly as of now.

I have to wonder then what subsystems of Linux is
user-friendlier than SCSI subsystem. I don't know.
I have configured network card, Intel EEPRO/100 under linux,
and didn't have much trouble, but then
I have configured network at the office many many times, and
so it helped me, I guess.

In comparison, the problem with Linux SCSI subsystem is that
I have configured SCSI disks, tape drives, etc. at the office
many times, but the experience didn't carry over very well.
That is it.

I can't pin point what (mis-)features of linux make it difficult
for  me to share the past SCSI experience:
Maybe the devfs thing would help if only it has
better introduction documents somewhere.

It could be that this is the fate of open source system where the
device drivers are written by totally independent groups
with various features creeping/implemented  at different
speeds in different drivers. If this is the case, then
there is no intrinsic cure.

Anyway, better documentation would help to certain extent certainly.
The paragraph between " ......" above can be
ripped and inserted with more detailed explanation of
scsihosts in such a document.

Anyway, viewing the (end) users as dumb who just want to play
puts me in a very uncomfortable position.
I guess (hope) I am not that dumb at all, and yet
for heaven's sake, I could not get my two SCSI cards
working for a few weeks (due to a bug), and I had
read the docs many times during the time.

There will be more users like Michael Meissner and me
who have past experience with other systems before
and yet a NEWBIE linux users initially: There will be
more such users since Linux seems to get more management
nods in the future.

And these experienced NEWBIESs probably
can't figure out these SCSI problems under linux either and
I frankly doubt if the old SCSI-HOWTO docs might help.
(I checked a few web pages : was the current
how-to re-written in 1996?)

Something needs to be done here.

PS: I have now about 5 or 6 SCSI host adaptors in
a few PC boxes.
I hate IDE/ATA disks with all the geometry problems.
Also, being able to use external drives help cool down
the PC boxes IMHO.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

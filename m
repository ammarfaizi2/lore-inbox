Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSFDWhH>; Tue, 4 Jun 2002 18:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFDWhH>; Tue, 4 Jun 2002 18:37:07 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:63725 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S316903AbSFDWhF>; Tue, 4 Jun 2002 18:37:05 -0400
Date: Tue, 4 Jun 2002 18:36:43 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Jorge Nerin <comandante@zaralinux.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Cannot write a 90' cd
In-Reply-To: <3CED7A65.7010004@zaralinux.com>
Message-ID: <Pine.GSO.4.33.0206041828420.10816-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, Jorge Nerin wrote:
>It could be that, but I suspect something strange, the cd reports itself to be
>about 80', then cdrecord is unable to write past this 80', after cdrecord
>fixates the cd and ejects it I can see that there is still a virgin zone of
>about 5 milimeters at the edge of the disk.

Are you sure the head can move that far out on the disk?  What you are doing
is far beyond any CD-ROM specs.

>The most strange thing is the scsi error, "no error":

That is referring to the "sendcmd" (i.e. the OS did not have a problem
executing the request, the drive idicated a fault.)

>CDB:  2A 00 00 05 7D 89 00 00 1F 00
>status: 0x2 (CHECK CONDITION)
>Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 63 00 00 00
>Sense Key: 0x5 Illegal Request, Segment 0
>Sense Code: 0x63 Qual 0x00 (end of user area encountered on this track) Fru 0x0

The sense data cannot be any more to the point.

Check with the drive manufacturer to see if it can write off the edge of the
disk. (It's rumored some plextor drives are able to continue writing off the
end of the disk into the air :-)  Somehow I doubt the last bit, but all of
mine have continued writing as long as they have a surface on which to
focus the laser.)

--Ricky



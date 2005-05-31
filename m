Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVEaLuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVEaLuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVEaLuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:50:04 -0400
Received: from alog0101.analogic.com ([208.224.220.116]:22994 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261859AbVEaLt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:49:56 -0400
Date: Tue, 31 May 2005 07:46:03 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mrmacman_g4@mac.com, toon@hout.vanvergehaald.nl, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
In-Reply-To: <429C4483.nail5X0215WJQ@burner>
Message-ID: <Pine.LNX.4.61.0505310728270.26221@chaos.analogic.com>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-924529756-1117539963=:26221"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-924529756-1117539963=:26221
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 May 2005, Joerg Schilling wrote:

> Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
>>> BTW: an implementation that uses something like Solaris does with
>>> /etc/path_to_inst and puts USB serial numbers into the path_to_inst
>>> kernel instance database could come very close to the desired result
>>> and would give stable SCSI addresses too.
>>
>> But why fix what isn't broken?  I can tell all my other programs, from
>> dd to mount, that I want to use the udev-created /dev/green_burner, so
>> why do you indicate such usage is _deprecated_ in cdrecord?  For such
>> device nodes, a _filesystem_ is the preferred name=3D>number index, so
>> why add an extra strange file "just because Solaris does".
>
> If you use /dev/ entries to directly address SCSI targets, then you
> are relying on on assumptions that cannot be granted everywhere.
>
> Cdrecord is portable and this needs to implement a way that is portable
> and does not rely on nonportable assumptions like yours.
>

Portability is relative. It's normally handled with a wrapper.
If your software is to work on a Unix or Unix-like machine, a
claim to "portability" must mean that its interface on a Unix-
like machine is either through a virtual file in '/dev' or
through a socket. This is because these are the 'standards'
that we all have to live with whether we like then or not.

Your `cdrecord -scanbus` hack to find I,J,K numbers that the
rest of your code was written to use, probably took more
time to write than a Unix wrapper which would provide the
correct (for a Unix environment) interface semantics.

Administrators need to set up symbolic links for /dev/burner
or /dev/cdreader, etc., to help cut down nuisance complaints
from users who fail to write CDs on their CD readers. This
is the de-facto Unix way. We need 'devices' in /dev.

BYW I have used your software from its inception and it
always worked well in my SCSI environment. The best working
software in the universe will not receive due credit if
it doesn't meet user (and customer) expectations. If you
are still interested in improving your generous gift to
the Linux community, you should seriously consider writing
wrappers  to address portability issues.

>
>> And why again do you need stable SCSI addresses for my _USB_ drive?
>
> Well if the udev program was polite to users, it would also support
> to edit /etc/default/cdrecord......
>
> ... if it _really_ does wat you like with /dev/ links, then it has all
> the information that is needed to also maintain /etc/default/cdrecord
>
>
>
> J=F6rg
>
> --=20
> EMail:joerg@schily.isdn.cs.tu-berlin.de (home) J=F6rg Schilling D-13353 B=
erlin
>       js@cs.tu-berlin.de=09=09(uni)
>       schilling@fokus.fraunhofer.de=09(work) Blog: http://schily.blogspot=
=2Ecom/
> URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/sc=
hily
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-924529756-1117539963=:26221--

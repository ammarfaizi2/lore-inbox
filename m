Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282602AbRKZXta>; Mon, 26 Nov 2001 18:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282658AbRKZXtU>; Mon, 26 Nov 2001 18:49:20 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:10113 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S282602AbRKZXtG>; Mon, 26 Nov 2001 18:49:06 -0500
Message-ID: <002f01c176d4$f79a3f70$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Steve Brueggeman" <xioborg@yahoo.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de> <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42> <3C002D41.9030708@zytor.com> <0f050uosh4lak5fl1r07bs3t1ecdonc4c0@4ax.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: Tue, 27 Nov 2001 00:49:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Steve Brueggeman" <xioborg@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, November 26, 2001 7:05 PM
Subject: Re: Journaling pointless with today's hard disks?

<snip>

> >There is no "power monitor" in a PC system (at least not that is visible
> >to the drive) -- if the drive needs it, it has to provide it itself.
> >
> >It's definitely the responsibility of the drive to recover gracefully
> >from such an event, which means that it writes anything that it has
> >committed to the host to write;
> Correct.  If a write gets interrupted in the middle of it's operation,
> it has not yet returned any completion status, (unless you've enabled
> write-caching, in which case, you're already asking for trouble)  A
> subsequent read of this half-written sector can return uncorrectable
> status though, which would be unfortunate if this sector was your
> allocation table, and the write was a read-modify-write.
>
> >anything it hasn't gotten committed to
> >write (but has received) can be written or not written, but must not
> >cause a failure of the drive.
> Reading a sector that was a partial-write because of a power-loss, and
> returning UNCORRECTABLE status, is not a failure of the drive.

I sure think the drives could afford the teeny-weeny cost of a power failure
detection unit, that when a power loss/sway is detected, halts all
operations to the platters except for the writing of the current sector.

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden



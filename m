Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263905AbTJ1Ldh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 06:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTJ1Ldh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 06:33:37 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:36265 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S263905AbTJ1Ldf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 06:33:35 -0500
Message-ID: <058d01c39d47$39becbb0$f3ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>, <jw@pegasys.ws>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>
Subject: Re: Blockbusting news, results end
Date: Tue, 28 Oct 2003 20:31:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:

> > I am assuming that these numbers are applicable (one is
> > unknown):
> > logical sector size == 512B
> > physical sector size == ???B
> > page size/filesystem block size == 4KB
>
> I have dialoged with Eric Mudama.  He is 99% sure that no
> manufacturer of is making ATA drives with physical sectors
> larger than 512B.  I'll let that statement trump Norman
> Diamond's until i hear otherwise.

Someone else in this discussion estimated that physical sectors are around
1MB these days.  My friends at Toshiba confirmed that physical sectors are
much larger than logical sectors.  The physical sector size resembles that
1MB estimate far better than the 512B logical sector size.

> The drive manufacturers would like to be able to go to a
> larger physical sector but the read-modify-write is just too
> scary.

It is really hard to imagine a physical sector still being 512B because the
inter-sector gaps would take some huge multiple of the space occupied by the
sectors.  I think this discussion has proved that we need to be scared of
read-modify-writes, but I think the drive manufacturers are doing it even
though it is scary.

> If they could be sure of market acceptance of drives
> that required all I/O to be in larger units they would build
> them because it would allow greater capacity (and i'm
> guessing speed as well) on the same physical hardware.

No, the effect on speed is the opposite.  A simple write could be done with
one seek and a random fraction of a rotational delay.  A read-modify-write
requires one seek and a random fraction plus additional entire rotational
delay.

I want to ask my friends why the read-modify-write behavior changed between
a 512B write and a 4096B write.  When the drive finally reallocated the
defective sector, it was during a 4096B write.  But I don't think they'll be
allowed to answer.  They already weren't allowed to talk much about the
firmware, but they did confirm that my original complaints about the
defective firmware were pretty accurate.

By the way, a few years ago when I visited other departments at Toshiba's
local division, I walked past a lot of ordinary large open-layout offices,
and also walked past one highly secured door.  That door had a sign on it
(in Japanese) saying that entry was prohibited to anyone not working on disk
drive design.  The accidental occurences by which I became friends with some
of their disk drive engineers were not a result of those business visits.
Probably there is no way that Toshiba would ever officially publicize even
the limited amount of information that my friends admitted to.  Nonetheless,
I'm sure the physical sectors are not 512B.


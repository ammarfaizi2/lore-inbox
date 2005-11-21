Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVKUUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVKUUsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVKUUsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:48:50 -0500
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:27036 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932459AbVKUUst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:48:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=XXqpnIgh56DmOynmOf5v1up3JYtCLPdbMdxiN05SHbTCZ10EMrT6KpfvKCCLEhIY;
  h=Received:Message-ID:From:To:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MIMEOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <008801c5eedc$f7277060$1225a8c0@kittycat>
From: "jdow" <jdow@earthlink.net>
To: "Matthias Andree" <matthias.andree@gmx.de>, <linux-kernel@vger.kernel.org>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051121114654.GA25180@merlin.emma.line.org> <1132574831.15938.14.camel@localhost> <20051121131832.GB26068@merlin.emma.line.org>
Subject: Re: what is our answer to ZFS?
Date: Mon, 21 Nov 2005 12:48:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b571120114905d20951c4daa2170a23f039bfc85eef737d2b58ce7c350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.163.224
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthias Andree" <matthias.andree@gmx.de>

> On Mon, 21 Nov 2005, Kasper Sandberg wrote:
>
>> On Mon, 2005-11-21 at 12:46 +0100, Matthias Andree wrote:
>> > On Mon, 21 Nov 2005, Jörn Engel wrote:
>> >
>> > > o Checksums for data blocks
>> > >   Done by jffs2, not done my any hard disk filesystems I'm aware of.
>> >
>> > Then allow me to point you to the Amiga file systems. The variants
>> > commonly dubbed "Old File System" use only 448 (IIRC) out of 512 bytes
>
> Make that 488. Amiga's traditional file system loses 6 longs (at 32 bit
> each) according to Ralph Babel's "The Amiga Guru Book".

FYI it was not used very often on hard disk file systems. The affect on
performance was "remarkable". Each disk block contained a simple ulong
checksum, a pointer to the next block in the file, and a pointer to the
previous block in the file. The entire file system was built of doubly
linked lists. It was possible to effect remarkable levels of "unerase"
and recover from disk corruption better than most other filesystems I
have seen. But it bad watching glass flow seem fast when you tried to
use it. So as soon as the Amiga Fast File System, FFS, was developed
OFS became a floppy only tool. That lasted until FFS was enabled for
floppies, months later. Then OFS became a legacy compatability feature
that was seldom if ever used by real people. I am not sure how I would
apply a checksum to each block of a file and still maintain reasonable
access speeds. It would be entertaining to see what the ZFS file system
does in this regard so that it doesn't slow down to essentially single
block per transaction disk reads or huge RAM buffer areas such as had
to be used with OFS.

>> > in a data block for payload and put their block chaining information,
>> > checksum and other "interesting" things into the blocks. This helps
>> > recoverability a lot but kills performance, so many people (used to) use
>> > the "Fast File System" that uses the full 512 bytes for data blocks.
>> >
>> > Whether the Amiga FFS, even with multi-user and directory index updates,
>> > has a lot of importance today, is a different question that you didn't
>> > pose :-)

Amiga FFS has some application today, generally for archival data
recovery. I am quite happy that potential is available. The Amiga FFS
and OFS had some features mildly incompatable with 'ix type filesystems
and these features were used frequently. So it is easier to perpetuate
the old Amiga FFS images than to copy them over in many cases.

>> that isnt true, just because it isnt following the kernel coding style
>> and therefore has to be changed, does not make it any bit more unstable.
>
> If the precondition is "adhere to CodingStyle or you don't get it in",
> and the CodingStyle has been established for years, I have zero sympathy
> with the maintainer if he's told "no, you didn't follow that well-known
> style".

Personally I am not a fan of the Linux coding style. However, if I am
going to commit a patch or a large block of Linux only code then its
style will match my understanding of the Linux coding style. This is
merely a show of professionalism on the part of the person creating the
code or patch. A brand new religious war over the issue is the mark of
a stupid boor at this time. It is best to go with the flow. The worst
code to maintain is code that contains eleven thousand eleven hundred
eleven individual idiosyncratic coding styles.

> Matthias Andree

{^_^}   Joanne Dow, who pretty much knows Amiga filesystems inside and
        out if I feel a need to refresh my working memory on the subject.



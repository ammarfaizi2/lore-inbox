Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTF2TWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTF2TWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:22:25 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:44012 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263062AbTF2TWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:22:10 -0400
Date: Sun, 29 Jun 2003 15:35:05 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <20030629192847.GB26258@mail.jlokier.co.uk>
To: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Message-id: <200306291535050230.0209B20B@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <20030629192847.GB26258@mail.jlokier.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 8:28 PM Jamie Lokier wrote:

>Leonard Milcin Jr. wrote:
>> I think that filesystem conversion on-the-fly is useless. Why? If you're
>> making conversion of filesystem, you have to make good backup of data
>> from that filesystem.
>
>I disagree with this statement.
>

Me too.  It's a GOOD IDEA.  But... heck we don't all have tape backups.

>> It is likely that when something goes wrong during
>> conversion (power loss) filesystem will be corrupted, and data will be
>> lost.
>
>Only if the converter stores a temporarily inconsistent state on the
>filesystem.  Sometimes it is possible to write a converter where the
>filesystem is in a consistent state throughout, except perhaps during
>a critical transition from one filesystem type to the other.
>

Dude come on I said put a journal in the datasystem so you DON'T get
inconsistencies like that! (A roll-back journal)

>> If you think the data is not worth to make backup - you don't have
>> to convert it. Just delete worthless filesystem, and create new one.
>> I
>> the data is worth making backup, and finally you make it - you don't
>> need to convert it.
>
>You are discounting the existence of data which is valuable enough not
>to have deleted already, yet which is not valuable enough to backup.
>I'd count local mirrors in this category: backup is too expensive, yet
>the cost of recreating the mirror is significant (days of
>downloading), therefore worth keeping if possible.
>

Mmhmm

>Also MP3 & DIVX collections etc.  If you lose them it's not the end of
>the world, but you'd rather not.
>

HEY!  It IS the end of the world if I lose /data/audio !!!!!!! I can't code
without music!

>> You could just delete filesystem, and restore data
>> from copy. If in turn one think the data is worth to protect it from
>> loss, but he will not do it... he risks that the data will be lost, and
>> he should not get access to such things.
>     ^^^^^^
>
>It may not be worth it to _you_, but to me the cost of spare disks is
>significant enough that I choose to risk my less valuable data.  It's
>my data hence my choice.
>

You forgot something.  I only risk bugs in the code, that's why there's a
journal.  You can have a bug in the filesystem code.  You're taking the
same risks doing the conversion that you are mounting th efilesystem.

>> I think that copying data to another filesystem, and restoring it to
>> newly created  is most of the time best and fastest method of converting
>> filesystems.
>
>You are right that this diminishes the value of an in-place filesystem
>converter (and defragmenter), because it is not necessary if you have
>the foresight to use multiple partitions or LVM, and enough spare disk
>space.q
>

Erm?  Not everyone has spare disk space or wants to be assed with it.
Those methods take more work.

>However it would still be useful to some people, some of the time.
>
>Consider that many people choose ext3 rather than reiser simply
>because it is easy to convert ext2 to ext3, and hard to convert ext2
>to reiser (and hard to convert back if they don't like it).  I have
>seen this written by many people who choose to use ext3.  Thus proving
>that there is value in in-place filesystem conversion :)
>

that's me.  I cite that I want to go from reiser3.6 to reiser4, but I have only
one reiser3.6.  I used to have all reiserfs, and yes it was a lot faster.  Now
I want it back.

>-- Jamie




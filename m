Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbTF2SNn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbTF2SNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:13:43 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:25790 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265722AbTF2SNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:13:17 -0400
Date: Sun, 29 Jun 2003 14:26:04 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
To: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Message-id: <200306291426040670.01CA818A@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 11:11 AM John Bradford wrote:

>> Anyhow, I'm thinking still about when reiser4 comes out.  I want to
>> convert to it from reiser3.6.  It came to my attention that a user-space
>> tool to convert between filesystems is NOT the best way to deal with
>> this. Seriously, you'd think it would be, right?  Wrong, IMHO.
>>
>> You have the filesystem code for every filesystem Linux supports.  It's
>> there, in the kernel.  So why maintain a kludgy userspace tool that has
>> to be rewritten to understand them all?  I have a better idea.
>>
>> How about a kernel syscall?  It's possible to do this on a running
>> filesystem but it's far too difficult for a start, so let's start with
>> unmounted filesystems mmkay?
>
>Apart from the special case of converting from one major version of a
>filesystem to another major version of the same filesystem, I think
>the performance of an on-the-fly filesystem conversion utility is
>going to be so much worse than just creating a new partition and
>copying the data across, that the only reason to do it would be if you
>could do it on a read-write filesystem without unmounting it.
>

You've entirely missed the point :/  Did you read the last section?  I noted
that the "make new partition and copy" method requires, first off, space
for a new partition.  All my partitions have massive amount of data on them.
I can't do that.  Those of us that can have to either do it twice, or rewrite
fstab.

Eventually I'm hoping it can be done on a read-write filesystem.  It's
possible; I've thought about how to defragment read-write datasystems
without getting in the way of logical operations.

>What I'd like to see is union mounts which allowed you to mount a new
>filesystem of a different type over the original one, and have all new
>writes go to the new fileystem.  I.E. as files were modified, they
>would be re-written to the new FS.  That would be one way of avoiding
>the performance hit on a busy server.
>

mmmm, then you'd need both fs' though.  That's not conversion ;-)


>John.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--Bluefox Icy


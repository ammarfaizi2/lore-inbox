Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTF2Te1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTF2TeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:34:13 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:6477 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264881AbTF2Tbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:31:52 -0400
Date: Sun, 29 Jun 2003 15:44:10 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFF3FFA.60806@post.pl>
To: "Leonard Milcin Jr." <thervoy@post.pl>, linux-kernel@vger.kernel.org
Message-id: <200306291544100750.0212055A@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl>
 <200306291445470220.01DC8D9F@smtp.comcast.net> <3EFF3FFA.60806@post.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 9:37 PM Leonard Milcin Jr. wrote:

>> Nrrrg.  Yeah, I've got 80 gig and only CDR's to back up to, and no
>money.
>> A CDR may read for me the day it's written, and then not work the next
>> day.  Still a risk.
>
>Say, why you would want to change filesystem type?
>

I installed debian and it couldn't boot bk24 (kernel 2.4) at install, so I have
like 1 reiserfs partition (created afterwards,  because at the time I had
10 gig free) and the rest are ext3.  ext3 is VERY slow.  I know, it's not
THAT slow, but... I have like 5 partitions on each disk, and 2 disks.  So,
take off swap and reiserfs, like 6 at one time.  Painful.

>If you have to change filesystem type, I think it is because you have a
>good reason to do it. I can't imagine the reason explaining the need of
>converting filesystem if you use this system as home desktop. For
>ordinary user filesystem is just used for storing data and managing
>permissions to that data. These are not real-time or
>performance-critical systems. Thus most of the popular filesystems like
>ext2, ext3, reiserfs basically fit their needs. If they choose right
>filesystem type at startup, they could use it for a time of life of
>their hard disk.
>

reiserfs is the filesytem that servers should use.  It has the least latency
these days ;-) And it's quite stable.

>There are very few situations when you really need to convert
>filesystem. Most of the time this operation is done by person who have
>some experience with computers, and highly probable by person who has
>access to additional hard disks, etc. I have never heard of one who had
>to change filesystem type, and had no access to additional equipment.
>

Some of us are walking brains with very shallow pockets.

>I don't want to say it is not possible, to provide such a function
>safely. What I want to say is that kernel developers should not
>complicate filesystem code without *very* good reason. I think that
>providing on-the-fly conversion capability is not a good reason. Good
>reason is when you can improve usability for many users and most of the
>time, not when you ease one operation needed by very few users few times
>in their life, especially when they can do what they need by just
>transferring their data back and forth to another disk, or machine.
>

The filesystem code wouldn't be much more complicated.  The changes
needed for this would all be in a separate source file anyway.  Most of the
complicated crap is all in the code for the datasystem that manages the
two filesystems that suddenly exist in the same space.

>
>Regards,
>
>
>Leonard Milcin Jr.
>
>
>--
>"Unix IS user friendly... It's just selective about who its friends are."
>                                                        -- Tollef Fog Heen
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--Bluefox Icy


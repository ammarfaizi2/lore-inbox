Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265735AbTF2SRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 14:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbTF2SRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 14:17:24 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:24584 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265735AbTF2SRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 14:17:13 -0400
Date: Sun, 29 Jun 2003 14:31:08 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: File System conversion -- ideas
In-reply-to: <3EFEEEC3.30505@sktc.net>
To: "David D. Hagood" <wowbagger@sktc.net>, linux-kernel@vger.kernel.org
Message-id: <200306291431080580.01CF24BF@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
 <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEEC3.30505@sktc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 6/29/2003 at 8:50 AM David D. Hagood wrote:

>This is a place where logical volume management can help.
>
>For example, suppose you have a 60G disk, 55G of data, in ext2, and you
>wish to convert to ReiserFS.
>
>Step 1: Shrink the volume to 55G. This requires a "shrink disk" utility
>for the source file system (which exists for the major file systems in
>use today).
>Step 2: Create an LVM block in the remaining 5G.
>Step 3: Create a ReiserFS in the LVM block.
>Step 4: Move 5G of data from the ext2 system to the ReiserFS block.
>Step 5: Shrink the ext2 volume by another 5G
>Step 6: Convert that 5G into an LVM block
>Step 7: Add that block to the ReiserFS volume group.
>Step 8: Grow the ReiserFS.
>Step 9: Repeat 4-8 as needed.
>

Ass yourself for hours, each time risking making a typo and killing both
filesystems, or risking having the LVM resize die from a powerdrop or a kick
to the power button (sorry we don't all have immortal fault tolerance).  I actually
though about this one and figured it was too rediculously annoying to actually
bring up :-p

>
>This is why I'd really love to see LVM|EVM become standard, not just in
>the kernel but in the distributions - if every distro by default made
>all Linux volumes in LVM, then migrating data to bigger drives/adding
>more space/converting file systems would be so much easier.
>

I've never used LVM, but I'll look at it one day.  If it's stable, that's good; I
don't use Windows.  I don't know exactly what LVM is but I have a pretty
good idea; it's been forever since I read the doc on it, I forgot what it said!

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--Bluefox Icy


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbUK3HRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUK3HRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbUK3HRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:17:02 -0500
Received: from quechua.inka.de ([193.197.184.2]:37606 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261585AbUK3HQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:16:57 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
Organization: Deban GNU/Linux Homesite
In-Reply-To: <41ABF7C5.5070609@comcast.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CZ2Fp-0005O7-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 30 Nov 2004 08:16:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41ABF7C5.5070609@comcast.net> you wrote:
> when done; however, whatever the result, I'd assuredly give a free
> license to implement the resulting file system in GPL2 licensed code (if
> you're not making money off it, I'm not making money off it).

You can't restrict the GPL.

> I've examined briefly the overall concepts which go into several file
> systems and pooled them together to create my basic requirements.  In
> these include things such as:

It is not a good idea to publish your ideas if you want to patent them.

> - - localization of Inodes and related meta-data to prevent disk thrashing

Why do you asume inodes?

> - - 64 bit indices indicating the exact physical location on disk of
> Inodes, giving a O(1) seek to the Inode itself

How is that different from Logical Block Numbers with a fixed cluster
factor? (besides it wastes more bits)

> - - A design based around preventing information leaking by guaranteed
> secure erasure of data (insofar that the journal even will finish wiping
> out data when replaying a transaction)

Hopefully  optional.

> 2)  Are there any other security concerns aside from information leaking
> (deleted data being left over on disk, which may pop up in incompletely
> written files)?

IT-Security is about availability and reliability also.

> 3)  What basic information do I absolutely *need* in my super block?

How should  WE know? (For mount you might want to have versioning and uuids)

> 5)  What basic information do I absolutely *need* in my directory
> entries? (I'm thinking {name,inode})

Think about optimizations like NTFS, where you can sort directories by
attributes and store often used attribtes in the dir, so you dont need a
inode dereference (MFT lookup in case of ntfs)

> Directories will have to be some sort of on disk BsomethingTree. . . B*,
> B+, something.  I have no idea how to implement this :D  I'll assume I
> treat the directory data as a logically contiguous file (yes I'm gonna
> store directory data just like file data).  I could use a string hash of
> the Directory Entry name with disambiguation at the end, except my
> options here seem limited:

Dont forget to optimize  directories for all  4: insertion/deletion/lookup
and traversal.

> I guess the second would be better?  I can't locate any directories on
> my drive with >2000 entries *shrug*.  The end key is just the entry
> {name,inode} pair.

Do you want to run old style NNTP Servers?

> Any ideas?

In fact I miss a bit a new idea, so what makes your FS better, why should
anyone use a non-open source implementation if it does not provide anything
new?

Greetings
Bernd

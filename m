Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWHPMiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWHPMiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWHPMiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:38:13 -0400
Received: from news.cistron.nl ([62.216.30.38]:46765 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1751151AbWHPMiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:38:12 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Date: Wed, 16 Aug 2006 12:38:10 +0000 (UTC)
Organization: Wurtelization
Message-ID: <ebv3ji$gls$1@news.cistron.nl>
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com> <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com> <20060814120032.E2698880@wobbly.melbourne.sgi.com>
X-Trace: ncc1701.cistron.net 1155731890 17084 83.68.3.130 (16 Aug 2006 12:38:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott  <nathans@sgi.com> wrote:
>On Fri, Aug 11, 2006 at 12:25:03PM +0200, Jesper Juhl wrote:
>> I didn't capture all of the xfs_repair output, but I did get this :
>> ...
>> Phase 4 - check for duplicate blocks...
>>         - setting up duplicate extent list...
>>         - clear lost+found (if it exists) ...
>>         - clearing existing "lost+found" inode
>>         - deleting existing "lost+found" entry
>>         - check for inodes claiming duplicate blocks...
>>         - agno = 0
>>         - agno = 1
>>         - agno = 2
>>         - agno = 3
>>         - agno = 4
>>         - agno = 5
>>         - agno = 6
>> LEAFN node level is 1 inode 412035424 bno = 8388608
>
>Ooh.  Can you describe this test case you're using?  Something with
>a bunch of renames in it, obviously, but I'd also like to be able to
>reproduce locally with the exact data set (file names in particular),
>if at all possible.

>From your reaction above I gather that "LEAFN node level is 1 inode ..."
is a bad thing?

My filesystem (that crashes under heavy load, while rsyncing to and from
it) has a lot of these messages when xfs_repair is run.

Note that I've now put an older kernel on the system (2.6.15.6) and it
seems to be surviving longer than before, with 2.6.17.7. It would be
nice if it survived a day, as it's a backup server for a couple of
important things...

(See also my messages to the xfs list, subject "cache_purge: shake on
cache 0x5880a0 left 8 nodes!?" and "XFS internal error
XFS_WANT_CORRUPTED_GOTO".)


Paul Slootman


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131673AbRAJQJv>; Wed, 10 Jan 2001 11:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131686AbRAJQJl>; Wed, 10 Jan 2001 11:09:41 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:61196 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131673AbRAJQJf>; Wed, 10 Jan 2001 11:09:35 -0500
Date: Wed, 10 Jan 2001 11:09:10 -0500
From: Chris Mason <mason@suse.com>
To: "Vladimir V. Saveliev" <vs@namesys.botik.ru>
cc: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
  Linux)
Message-ID: <205320000.979142950@tiny>
In-Reply-To: <3A5C8780.5B02EC8A@namesys.botik.ru>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 10, 2001 07:02:08 PM +0300 "Vladimir V. Saveliev"
<vs@namesys.botik.ru> wrote:

> Hi
> 
> Chris Mason wrote:
> 
>> On Wednesday, January 10, 2001 02:32:09 AM +0100 Marc Lehmann
>> <pcg@goof.com> wrote:
>> 
>> >>> EIP; c013f911 <filldir+20b/221>   <=====
>> > Trace; c013f706 <filldir+0/221>
>> > Trace; c0136e01 <reiserfs_getblk+2a/16d>
>> 
>> The buffer reiserfs is sending to filldir is big enough for
>> the huge file name, so I think the real fix should be done in VFSland.
>> 
>> But, in the interest of providing a quick, obviously correct fix, this
>> reiserfs only patch will refuse to create file names larger
>> than 255 chars, and skip over any directory entries larger than
>> 255 chars.
>> 
> 
> Hmm, wouldn't it make existing long named files unreachable?
> 

Yes, that was intentional.  We can make a different version of the patch
that changes reiserfs_find_entry to allow opening the large filenames for
delete and such.  But, as a quick fix, I wanted to close all possible paths
to the long names.

-chris
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

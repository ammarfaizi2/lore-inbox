Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRCPFab>; Fri, 16 Mar 2001 00:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRCPFaW>; Fri, 16 Mar 2001 00:30:22 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:35600
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S129679AbRCPFaS>; Fri, 16 Mar 2001 00:30:18 -0500
Date: Fri, 16 Mar 2001 00:29:34 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, David <david@blue-labs.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] report
Message-ID: <635010000.984720574@tiny>
In-Reply-To: <Pine.GSO.4.21.0103152131230.10709-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, March 15, 2001 09:44:48 PM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Thu, 15 Mar 2001, David wrote:
> 
>> 2.4.2-ac4
>> 
>> Mar 15 18:02:49 Huntington-Beach kernel: end_request: I/O error, dev 
>> 16:41 (hdd), sector 9512
>> Mar 15 18:02:49 Huntington-Beach kernel: hdd: drive not ready for command
>> Mar 15 18:02:48 Huntington-Beach kernel: hdd: drive not ready for command
>> Mar 15 18:02:49 Huntington-Beach kernel: hdd: status error: status=0x00
>> { } Mar 15 18:02:49 Huntington-Beach kernel: hdd: drive not ready for
>> command Mar 15 18:02:49 Huntington-Beach kernel: journal-601, buffer
>> write failed Mar 15 18:02:49 Huntington-Beach kernel: kernel BUG at
>> prints.c:332!
> 
> Umm... Chris, I really don't think that panic() (or BUG(), for that
> matter) is an appropriate reaction to IO errors. They are expected
> events, after all...
> 

Nods.  It needs to force a readonly mount instead.

> ObReiserfs_panic: what the hell is that ->s_lock bit about? panic()
> _never_ tries to do any block IO. It looks like a rudiment of something
> that hadn't been there for 5 years, if not longer. The same goes for
> ext2_panic() and ufs_panic(), BTW... I would suggest crapectomey here.

Ugh, that should have been dragged out and shot...patch will come in the AM.

-chris


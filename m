Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbRABQU1>; Tue, 2 Jan 2001 11:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRABQUR>; Tue, 2 Jan 2001 11:20:17 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:26373 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129450AbRABQUG>; Tue, 2 Jan 2001 11:20:06 -0500
Date: Tue, 02 Jan 2001 10:49:38 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <141100000.978450578@tiny>
In-Reply-To: <3A4CD0A9.3F8F6D16@innominate.de>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, December 29, 2000 06:58:01 PM +0100 Daniel Phillips
<phillips@innominate.de> wrote:

> Chris Mason wrote:
>> 
>> BTW, the last anon space mapping patch I sent also works on test13-pre5.
>> The block_truncate_page fix does help my patch, since I have bdflush
>> locking pages ( thanks Marcelo )
> 
> Yes it does, but the little additional patch you posted no longer
> applies.  Your patch is suffering badly under pre5 here, reducing
> throughput from around 10 MB/sec to 5-6 MB/sec, and highly variable.  If
> you're not seeing this you should probably try to get a few others to
> run it.
> 

The additional patch I sent (for skipping writepage calls on the first loop
in page_launder) was applied to test13-pre5, in a slightly better form.
So, you'll either need to benchmark in pre4, or make a reversed version for
pre5.

Porting to the prerelease now ;-)

-chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

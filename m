Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbRGRQBf>; Wed, 18 Jul 2001 12:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbRGRQBZ>; Wed, 18 Jul 2001 12:01:25 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:30216
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S267494AbRGRQBM>; Wed, 18 Jul 2001 12:01:12 -0400
Date: Wed, 18 Jul 2001 12:00:45 -0400
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs b_count usage
Message-ID: <309310000.995472045@tiny>
In-Reply-To: <20010718175342.B18183@athlon.random>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, July 18, 2001 05:53:42 PM +0200 Andrea Arcangeli
<andrea@suse.de> wrote:

> On Wed, Jul 18, 2001 at 10:25:20AM -0400, Chris Mason wrote:
>> @@ -2597,7 +2599,7 @@
>>  
>>    if (bh) {
>>      reiserfs_clean_and_file_buffer(bh) ;
>> -    atomic_dec(&(bh->b_count)) ; /* get_hash incs this */
>> +    put_bh(bh) ; /* get_hash grabs the buffer */
>>      if (atomic_read(&(bh->b_count)) < 0) {
>>        printk("journal-2165: bh->b_count < 0\n") ;
>>      }
> 
> in mainline you aren't calling reiserfs_clean_and_file_buffer above, so
> it rejects.

Correct, it goes cleanly on top of the direct->indirect cleanup patch that
was sent to l-k last week, and sent to linus for inclusion.  ac already has
it, so it should apply there.

-chris



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSK0Hwi>; Wed, 27 Nov 2002 02:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSK0Hwi>; Wed, 27 Nov 2002 02:52:38 -0500
Received: from mta03ps.bigpond.com ([144.135.25.135]:43241 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261646AbSK0Hwg> convert rfc822-to-8bit; Wed, 27 Nov 2002 02:52:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
Date: Wed, 27 Nov 2002 19:12:05 +1100
User-Agent: KMail/1.4.3
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>
References: <200211262203.20088.harisri@bigpond.com> <3DE3D1D1.BE5B30ED@digeo.com> <15843.54741.609413.371274@notabene.cse.unsw.edu.au>
In-Reply-To: <15843.54741.609413.371274@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211271912.05131.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

On Wednesday 27 November 2002 07:13, Neil Brown wrote:
> Srihari, could you possibly try with the following patch please to see
> if it gives more useful information.

No worries. That did the trick.

The following message appears just before the first oops:
Nov 27 18:56:32 localhost kernel: bio_add_page: want to add 4096 at 17658 but 
only allowed 3072 - prepare to oops...

second oops:
Nov 27 18:56:36 localhost kernel:  <3>bio_add_page: want to add 4096 at 426874 
but only allowed 3072 - prepare to oops...

And the third:
Nov 27 18:56:39 localhost kernel:  <3>bio_add_page: want to add 4096 at 427002 
but only allowed 3072 - prepare to oops...

Hope that helps. I can give the oops report(s) if you need (but they are once 
again the same "kernel BUG at drivers/block/ll_rw_blk.c:1950!").

Thanks.
-- 
Hari
harisri@bigpond.com


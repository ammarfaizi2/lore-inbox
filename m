Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136410AbREINEG>; Wed, 9 May 2001 09:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136403AbREINDt>; Wed, 9 May 2001 09:03:49 -0400
Received: from smtp.mountain.net ([198.77.1.35]:49673 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S136400AbREIND0>;
	Wed, 9 May 2001 09:03:26 -0400
Message-ID: <3AF93FED.DFBF6C37@mountain.net>
Date: Wed, 09 May 2001 09:02:37 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
In-Reply-To: <E14xTEi-0002E9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Trace; c01b956a <ide_build_dmatable+2a/120>
> > Trace; c01b3fb5 <ide_set_handler+55/60>
> > Trace; c01b9aca <ide_dmaproc+11a/210>
> > Trace; c01b9380 <ide_dma_intr+0/b0>
> > Trace; c01b9940 <dma_timer_expiry+0/70>
> > Trace; c01bd457 <do_rw_disk+257/300>
> > Trace; c01b4d2a <ide_wait_stat+7a/e0>
> > Trace; c01b5010 <start_request+160/210>
> > Trace; c01b51ff <ide_do_request+10f/340>
> 
> We seem to be several layers into recursive use of the ide driver - which
> shouldnt happen. In fact if these are the same interface the second dmatable
> build would leave HWIF(drive)->sg_table wrong.
> 
> > Trace; c01866ce <__make_request+4ae/6f0>
> > Trace; c01866e6 <__make_request+4c6/6f0>
> > Trace; c01b956a <ide_build_dmatable+2a/120>
> > Trace; c01b3fb5 <ide_set_handler+55/60>

I think maybe it smells like a configuration problem, I have a pair of ATAPI
drives on the second ide which I run with SCSI emulation. I'll see if I can
get a better look, with arguments to the calls.

Thanks,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson

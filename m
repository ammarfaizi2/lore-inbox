Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144867AbRA2DrW>; Sun, 28 Jan 2001 22:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145027AbRA2DrM>; Sun, 28 Jan 2001 22:47:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S144867AbRA2DrD>;
	Sun, 28 Jan 2001 22:47:03 -0500
Date: Mon, 29 Jan 2001 04:46:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.1-pre11 / ll_rw_b watermark metric?
Message-ID: <20010129044640.B15679@suse.de>
In-Reply-To: <01012904435200.00697@SunWave1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01012904435200.00697@SunWave1>; from Dieter.Nuetzel@hamburg.de on Mon, Jan 29, 2001 at 04:43:52AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, Dieter Nützel wrote:
> I have pre11 running with Andrea's suggested fix.
> 
>         high_queued_sectors = total_ram / 3;
>         low_queued_sectors = high_queued_sectors / 2;
>         if (low_queued_sectors < 0)
>                 low_queued_sectors = total_ram / 2;
>  
>         /*
>          * for big RAM machines (>= 384MB), use more for I/O
>          */
>         /*
>         if (total_ram >= MB(384)) {
>                 high_queued_sectors = (total_ram * 4) / 5;
>                 low_queued_sectors = high_queued_sectors - MB(128);
>         }
>         */
> 
> Shouldn't it be clean for a 2.4.1 release?

With enough swap the numbers I saw were not conclusive. I promised
to test which I haven't gotten done yet, I will do this tomorrow
and make sure we have the right ratios. However, I don't think
the pre11 numbers are much off - do you have any results?

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145104AbRA2D5m>; Sun, 28 Jan 2001 22:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145136AbRA2D5e>; Sun, 28 Jan 2001 22:57:34 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:58565 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S145104AbRA2D5S>; Sun, 28 Jan 2001 22:57:18 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Jens Axboe <axboe@suse.de>
Subject: Re: Linux-2.4.1-pre11 / ll_rw_b watermark metric?
Date: Mon, 29 Jan 2001 05:01:09 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <01012904435200.00697@SunWave1> <20010129044640.B15679@suse.de>
In-Reply-To: <20010129044640.B15679@suse.de>
MIME-Version: 1.0
Message-Id: <01012905010901.00697@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 29. Januar 2001 04:46 schrieb Jens Axboe:
> On Mon, Jan 29 2001, Dieter Nützel wrote:
> > I have pre11 running with Andrea's suggested fix.
> >
> >         high_queued_sectors = total_ram / 3;
> >         low_queued_sectors = high_queued_sectors / 2;
> >         if (low_queued_sectors < 0)
> >                 low_queued_sectors = total_ram / 2;
> >
> >         /*
> >          * for big RAM machines (>= 384MB), use more for I/O
> >          */
> >         /*
> >         if (total_ram >= MB(384)) {
> >                 high_queued_sectors = (total_ram * 4) / 5;
> >                 low_queued_sectors = high_queued_sectors - MB(128);
> >         }
> >         */
> >
> > Shouldn't it be clean for a 2.4.1 release?
>
> With enough swap the numbers I saw were not conclusive. I promised
> to test which I haven't gotten done yet, I will do this tomorrow
> and make sure we have the right ratios. However, I don't think
> the pre11 numbers are much off - do you have any results?

I have 256 MB RAM and 200 MB swap but nothing of the later was used during 
"dbench 48". It was nothing spectacular but a litte bit faster with the above.
Attention: Results only from memory...;-)

Good night.
	Dieter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291911AbSBASsb>; Fri, 1 Feb 2002 13:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291907AbSBASsV>; Fri, 1 Feb 2002 13:48:21 -0500
Received: from maila.telia.com ([194.22.194.231]:14551 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S291911AbSBASsO>;
	Fri, 1 Feb 2002 13:48:14 -0500
Message-Id: <200202011847.g11Ilwa14845@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Jens Axboe <axboe@suse.de>
Subject: Re: Errors in the VM - detailed
Date: Fri, 1 Feb 2002 19:44:54 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0202011708460.29576-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0202011708460.29576-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fridayen den 1 February 2002 17.11, Roy Sigurd Karlsbakk wrote:
> It does not seem to be possible to reproduce the error with apache2. But
> this may be because Apache2's i/o handling doesn't impress much. With Tux,
> I keep getting up to 40 megs per sec, but with Apache the average is
> ~15MB/s.
>
> Btw ... It looks like your patch (against rmap12a) gave me an extra
> performance kick. 12c gave me a max of ~32MB/s, whereas your patch
> highered this to ~41.
>

Hmm.. suppose this is the problem anyway and that Jens patch was not enough.
How do the disk drive sound during the test?

Does it start to sound more when performance goes down?

About Jens patch:

My feeling is that there should be (a lot) more  READA than READ.
since sequential READ really only NEEDS one at a time.

Number of READ limits the number of concurrent streams.
And READA limits the maximum total read ahead.

Jens said earlier "Roy, please try and change
the queue_nr_requests assignment in ll_rw_blk:blk_dev_init() to
something like 2048." - Roy have you tested this too?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283254AbRLDSqV>; Tue, 4 Dec 2001 13:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283282AbRLDSo5>; Tue, 4 Dec 2001 13:44:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10757 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283269AbRLDSnr>;
	Tue, 4 Dec 2001 13:43:47 -0500
Date: Tue, 4 Dec 2001 19:43:19 +0100
From: Jens Axboe <axboe@suse.de>
To: "David C. Hansen" <dave@sr71.net>
Cc: "Udo A. Steinberg" <reality@delusion.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS]: Linux-2.5.1-pre5
Message-ID: <20011204194319.C15152@suse.de>
In-Reply-To: <3C0BA978.A26EF6C0@delusion.de> <20011204104928.E13391@suse.de> <3C0D0DE8.9000902@sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0D0DE8.9000902@sr71.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04 2001, David C. Hansen wrote:
> Jens Axboe wrote:
> 
> >This should fix it.
> 
> So, what was the actual problem?

bio_alloc() not waiting on the reserved pool for free entries, even
though __GFP_WAIT was set. No need for __GFP_IO in that case too.

There were two hunks with actual code changes in there, did you read the
patch at all? :-)

-- 
Jens Axboe


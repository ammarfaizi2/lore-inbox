Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130243AbRBIXcL>; Fri, 9 Feb 2001 18:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131097AbRBIXcB>; Fri, 9 Feb 2001 18:32:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21512 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130243AbRBIXbp>;
	Fri, 9 Feb 2001 18:31:45 -0500
Date: Sat, 10 Feb 2001 00:31:40 +0100
From: Jens Axboe <axboe@suse.de>
To: David Welch <david.welch@st-edmund-hall.oxford.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Using loop driver on 2.4.2-pre2 with loop4 patch
Message-ID: <20010210003140.B7835@suse.de>
In-Reply-To: <20010209232842.A1118@whitehall1-5.seh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010209232842.A1118@whitehall1-5.seh.ox.ac.uk>; from david.welch@st-edmund-hall.oxford.ac.uk on Fri, Feb 09, 2001 at 11:28:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09 2001, David Welch wrote:
> Hi,
> 
> I received the following oops when using the loop driver on kernel 
> 2.4.2-pre2 patched with Jens Axboe's loop4 patch. I believe it occurs 
> because in loop.c, lo->lo_tsk is only assigned to by the loop thread when
> it starts up but it is possible for block requests to be sent to the 
> loop drivers before this happens.

Yep, this and other bugs have already been fixed. I will put out a loop-5
this weekend.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

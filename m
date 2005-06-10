Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFJS0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFJS0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 14:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFJS0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 14:26:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24033 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261163AbVFJSZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 14:25:55 -0400
Subject: Re: Real-time problem due to IO congestion.
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Jens Axboe <axboe@suse.de>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42A94611.8070502@lab.ntt.co.jp>
References: <42A91D36.8090506@lab.ntt.co.jp> <20050610062452.GK5140@suse.de>
	 <42A94611.8070502@lab.ntt.co.jp>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:26:46 -0400
Message-Id: <1118428006.6423.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 16:49 +0900, Takashi Ikebe wrote:
> Jens Axboe wrote:
> > On Fri, Jun 10 2005, Takashi Ikebe wrote:
> > 
> > This basically needs io priorities to work, so that request allocation
> > is prioritized as well. I didn't actually add request allocation groups
> > in the cfq-ts posted with priority support, however I have some patches
> > from years ago that did so. I'll see if I can find the time to brush
> > those off.
> > 
> 
> As you and andrew said, basically application based approach seems 
> reasonable,
> but I'm so interesting your patch, if you have time, please show me :-)

Take a look at the lock-free ringbuffers in JACK.  No point reinventing
the wheel...

I think it's a bit strange that the disk IO issue comes up so often in
these RT discussions, it's something of a red herring, because there's
rarely an RT constraint in getting the data to disk; the RT constraint
is in getting the data from the device to memory.

Lee


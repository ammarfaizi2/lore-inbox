Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273734AbRIQWbz>; Mon, 17 Sep 2001 18:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273730AbRIQWbA>; Mon, 17 Sep 2001 18:31:00 -0400
Received: from [194.213.32.137] ([194.213.32.137]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273722AbRIQWa2>;
	Mon, 17 Sep 2001 18:30:28 -0400
Date: Fri, 14 Sep 2001 09:15:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org, nigel@nrg.org
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
Message-ID: <20010914091558.A35@toy.ucw.cz>
In-Reply-To: <000901c138bbe151270/mnt/sendme10411ac@local> <1000007070.836.14.camel@phantasy> <001a01c1390262c7f30/mnt/sendme10411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001a01c1390262c7f30/mnt/sendme10411ac@local>; from manfred@colorfullife.com on Sun, Sep 09, 2001 at 09:38:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > #define kmap_atomic(page,idx) ctx_sw_off(); kmap(page);
> > #define kunmap_atomic(page,idx) ctx_sw_on(); kunmap(page);
> >
> No. kmap_atomic is called from interrupt context, and kmap calls
> schedule().
> 
> I thought about the attached patch (completely untested).

is it legal to kmap_atomic(a,b); kmap_atomic(c,d); kunmap_atomic(a,b); ?
If so, your patch may need some ounting....
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


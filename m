Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWDQPzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWDQPzG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 11:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWDQPzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 11:55:06 -0400
Received: from pproxy.gmail.com ([64.233.166.181]:56977 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbWDQPzF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 11:55:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eAZhKJz8moQgptCZtVQYhXDr5SKbm3j0yPvRnJN3tw1m1fz71zkyC2J3Ulae4XxSRZbP18nx7DEM3N+lvTNFNiacU5lbmH2AB2w2hJ6mTH+qHAeur32hhgMK7zcndo+5C56RYSXKXLai9LLhk/0Vnq9NDZg1NLVGzKOjK02Oc/I=
Message-ID: <728201270604170855t7a4257e7o28d70ea9f1a1c7ce@mail.gmail.com>
Date: Mon, 17 Apr 2006 10:55:04 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: select takes too much time
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0604142344000.4238@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
	 <443E9A17.4070805@stud.feec.vutbr.cz>
	 <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com>
	 <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
	 <443EC09C.2050409@stud.feec.vutbr.cz>
	 <728201270604140754g7bf955d6y5e06bc5ce4f86c7b@mail.gmail.com>
	 <Pine.LNX.4.61.0604141056120.11151@chaos.analogic.com>
	 <Pine.LNX.4.61.0604142344000.4238@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> So it seems that the only solution to return back right away after
> >> timeout is to play around with the scheduler or put the process doing
> >> select at the front of the queue so it get a chance to run first.
> >> Is there any other better way to do it?
> >>
> >       nice(-19);
>
>         sched_setscheduler(0, SCHED_FIFO,
>                 (struct sched_param){.sched_priority = 99});
>
> That should probably beat anything, with the exception of IRQs.

Thanks a lot. I will give it a try.

regards
Ram Gupta

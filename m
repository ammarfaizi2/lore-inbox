Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVJFQaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVJFQaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVJFQaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:30:39 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:65387 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751133AbVJFQai convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:30:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pAAzknl6C3CzQmm7QM/U31MV496qa5Q8w1eZqdw+ce24KPR9jwTkapvYT0VPaGDQ7gcnCZExq5k3DmuI+ABWZX40y9+buyX23TqmJiKQgMoERxfp7AI/tJCVQ3yojER6eD9vigXXj+pZY+HYYjKqoi+UhKPXFVjsu4IGCvmsmKM=
Message-ID: <5bdc1c8b0510060930y5648eacdm376178069dcd3958@mail.gmail.com>
Date: Thu, 6 Oct 2005 09:30:37 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128615988.14584.38.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
	 <20051006083043.GB21800@elte.hu>
	 <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
	 <1128615988.14584.38.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2005-10-06 at 09:00 -0700, Mark Knecht wrote:
> > Even with Jack running I don't see the jackd process getting any
> > special priority. Is this correct, or is that part that gets higher
> > prioity just not listed here.
>
> ps does not show all threads of multithreaded processes by default.
> Use:
>
> ps -Leo pid,pri,rtprio,cmd
>
> and you should see that 2 JACK threads get RT priority.
>
> Lee

Thanks Lee. That's what I thought might be happening.

8398  24      - hdspmixer
 8400  24      - qjackctl
 8400  49      9 qjackctl
 8402  20      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
 8402  20      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
 8402  23      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
 8402  60     20 /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
 8402  50     10 /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2

Cheers,
Mark

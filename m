Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWFSBwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWFSBwl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWFSBwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:52:41 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:39873 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750888AbWFSBwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:52:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
Date: Mon, 19 Jun 2006 11:52:27 +1000
User-Agent: KMail/1.9.3
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
References: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com> <1150680632.4428.129.camel@mindpipe>
In-Reply-To: <1150680632.4428.129.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191152.28038.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 11:30, Lee Revell wrote:
> On Sun, 2006-06-18 at 20:52 -0400, Albert Cahalan wrote:
> > > Make 250 HZ a value that is not selected by default and give some
> > > better recommendations in help.
> >
> > No, 250 is a good default.
> >
> > We can't reliably do 1000. There are many systems, including both
> > laptops and servers, which have a BIOS that uses SMM/SMI to grab
> > the CPU for longer than a millisecond. We'd lose clock ticks if
> > we had HZ at 1000.
>
> Doesn't this become a non-issue with John Stultz's gettimeofday rework?

No, but Thomas Gleixner's HRTimers will. Also the extra granularity in the cpu 
scheduler is desirable on a desktop.
>
> > NTSC video is 59.94 fields per second. Though a sample rate of
> > double that would satisfy the Nyquest theory, in practice you
> > need to go to 4x to 5x the rate you want. This comes out to be
> > around 240 to 300 as a minimum.
>
> Realtime audio wants higher framerates than video.  Of course many of
> these systems with the SMM bug are fatally broken for these
> applications.

Agreed.

-- 
-ck

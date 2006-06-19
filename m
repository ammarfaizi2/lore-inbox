Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWFSBag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWFSBag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWFSBag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:30:36 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13969 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751221AbWFSBag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:30:36 -0400
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
From: Lee Revell <rlrevell@joe-job.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com>
References: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 21:30:31 -0400
Message-Id: <1150680632.4428.129.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 20:52 -0400, Albert Cahalan wrote:
> > Make 250 HZ a value that is not selected by default and give some
> > better recommendations in help.
> 
> No, 250 is a good default.
> 
> We can't reliably do 1000. There are many systems, including both
> laptops and servers, which have a BIOS that uses SMM/SMI to grab
> the CPU for longer than a millisecond. We'd lose clock ticks if
> we had HZ at 1000.
> 

Doesn't this become a non-issue with John Stultz's gettimeofday rework?

> NTSC video is 59.94 fields per second. Though a sample rate of
> double that would satisfy the Nyquest theory, in practice you
> need to go to 4x to 5x the rate you want. This comes out to be
> around 240 to 300 as a minimum.

Realtime audio wants higher framerates than video.  Of course many of
these systems with the SMM bug are fatally broken for these
applications.

Lee


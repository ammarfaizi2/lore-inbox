Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSE0QnV>; Mon, 27 May 2002 12:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSE0QnU>; Mon, 27 May 2002 12:43:20 -0400
Received: from holomorphy.com ([66.224.33.161]:55721 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316682AbSE0QnT>;
	Mon, 27 May 2002 12:43:19 -0400
Date: Mon, 27 May 2002 09:43:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Muthal Sangam <sangam@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: interrupt latency/700microsecs
Message-ID: <20020527164303.GP14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Muthal Sangam <sangam@mail.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <E17CNNm-000GQe-00@f11.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 08:30:06PM +0400, Muthal Sangam wrote:
> On kernel 2.4.7, AMDK6 @ 450MHz processor, is it possible to get latency
> fluctuations of upto 700microsecs for running the timer interrupt, due to
> interrupts being disabled ?
> I am using the time stamp counter and reading it at the start of the timer
> interrupt and measuring the cycles elapsed between two inovocations of it.
> The number of cycles elapsed is ~4500225, but sometimes it increases to as
> high as 4848032. Can i conclude that this difference is due to interrupts
> being disabled in critical sections ? ( I think i am making some mistake :-)

IIRC there have been prior reports of excessive interrupt disablement
in 2.4.x, and also IIRC it was reported against a more recent kernel.
I think it was suspected there are bug(s) where some code is leaving
interrupts off and someone later unconditionally turns them back on.

Any chance you could upgrade to a more recent kernel and try to
reproduce there? There have been a number of critical bugfixes since 2.4.7
(and although none are particularly pertinent to this issue, people would
probably rather field bug reports for 2.4.19-pre* than 2.4.7).


Cheers,
Bill

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264099AbRFFTHo>; Wed, 6 Jun 2001 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264097AbRFFTHf>; Wed, 6 Jun 2001 15:07:35 -0400
Received: from www.wen-online.de ([212.223.88.39]:47367 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264096AbRFFTHU>;
	Wed, 6 Jun 2001 15:07:20 -0400
Date: Wed, 6 Jun 2001 21:06:52 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <m1ofs15tm0.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0106062102060.404-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jun 2001, Eric W. Biederman wrote:

> Derek Glidden <dglidden@illusionary.com> writes:
>
>
> > The problem I reported is not that 2.4 uses huge amounts of swap but
> > that trying to recover that swap off of disk under 2.4 can leave the
> > machine in an entirely unresponsive state, while 2.2 handles identical
> > situations gracefully.
> >
>
> The interesting thing from other reports is that it appears to be kswapd
> using up CPU resources.  Not the swapout code at all.  So it appears
> to be a fundamental VM issue.  And calling swapoff is just a good way
> to trigger it.
>
> If you could confirm this by calling swapoff sometime other than at
> reboot time.  That might help.  Say by running top on the console.

The thing goes comatose here too. SCHED_RR vmstat doesn't run, console
switch is nogo...

After running his memory hog, swapoff took 18 seconds.  I hacked a
bleeder valve for dead swap pages, and it dropped to 4 seconds.. still
utterly comatose for those 4 seconds though.

	-Mike


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSBDSyu>; Mon, 4 Feb 2002 13:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSBDSyf>; Mon, 4 Feb 2002 13:54:35 -0500
Received: from [216.151.155.108] ([216.151.155.108]:17676 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S286161AbSBDSyJ>; Mon, 4 Feb 2002 13:54:09 -0500
To: Aaron Sethman <androsyn@ratbox.org>
Cc: Darren Smith <data@barrysworld.com>, "'Andrew Morton'" <akpm@zip.com.au>,
        "'Dan Kegel'" <dank@kegel.com>,
        "'Vincent Sweeney'" <v.sweeney@barrysworld.com>,
        <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "'Kevin L. Mitchell'" <klmitch@mit.edu>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <Pine.LNX.4.44.0202041327420.4584-100000@simon.ratbox.org>
From: Doug McNaught <doug@wireboard.com>
Date: 04 Feb 2002 13:53:20 -0500
In-Reply-To: Aaron Sethman's message of "Mon, 4 Feb 2002 13:30:40 -0500 (EST)"
Message-ID: <m3r8o16pun.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman <androsyn@ratbox.org> writes:

> On Mon, 4 Feb 2002, Darren Smith wrote:
> 
> > I mean I added a usleep() before the poll in s_bsd.c for the undernet
> > 2.10.10 code.

> Why not just add the additional delay into the poll() timeout?  It just
> seems like you were not doing enough of a delay in poll().

No, because the poll() delay only has an effect if there are no
readable fd's.  What the usleep() does is allow time for more fd's to
become readable/writeable before poll() is called, spreading the
poll() overhead over more actual work.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280024AbRKSCdI>; Sun, 18 Nov 2001 21:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281883AbRKSCc7>; Sun, 18 Nov 2001 21:32:59 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:49936 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S280024AbRKSCcw>;
	Sun, 18 Nov 2001 21:32:52 -0500
Subject: Re: replacing the page replacement algo.
From: Shaya Potter <spotter@cs.columbia.edu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Shaya Potter <spotter@opus.cs.columbia.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111182344150.4079-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0111182344150.4079-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1 (Preview Release)
Date: 18 Nov 2001 21:31:15 -0500
Message-Id: <1006137133.604.8.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-18 at 20:44, Rik van Riel wrote:
> On 18 Nov 2001, Shaya Potter wrote:
> 
> > If I wanted to experiment with different algorithms that chose which
> > page to replace (say on a page fault) what functions would I have to
> > replace?
> 
> try_to_free_pages() and all the functions it calls.

I was looking at vmscan.c and it appears that swap_out() is what I
want.  If instead of having it step through the mmlist, I give it the
explicit mm of the processes that I want a page swapped out from? so I
could implement my algorithm either inside that func or as function
calls from it and have it pass onto swap_out_mm() the mm of the
processes I choose to swap out.

or am I totally misunderstanding something here? (likely, as this is my
first time digging into the vm and trying to learn about it)

thanks,

shaya potter


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272043AbRIDRyp>; Tue, 4 Sep 2001 13:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRyf>; Tue, 4 Sep 2001 13:54:35 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:2450 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S272043AbRIDRy1>; Tue, 4 Sep 2001 13:54:27 -0400
Date: Tue, 4 Sep 2001 13:54:27 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904135427.A30503@cs.cmu.edu>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <20010904131349.B29711@cs.cmu.edu> <Pine.LNX.4.21.0109041253510.2038-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109041253510.2038-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 12:56:32PM -0300, Marcelo Tosatti wrote:
> On Tue, 4 Sep 2001, Jan Harkes wrote:
> > One other observation, we should add anonymously allocated memory to the
> > active-list as soon as they are allocated in do_nopage. At the moment a
> > large part of memory is not aged at all until we start swapping things
> > out.
> 
> With reverse mappings we can completly remove the "swap_out()" loop logic
> and age pte's at refill_inactive_scan(). 
> 
> All that with anon memory added to the active-list as soon as allocated,
> of course.
> 
> Jan, I suggest you to take a look at the reverse mapping code. 

I'm getting pretty sick and tired of these endless discussion. People
have been reporting problems and they are pretty much alway met with the
answer, "it works here, if you can do better send a patch".

Now for the past _9_ stable kernel releases, page aging hasn't worked
at all!! Nobody seems to even have bothered to check. I send in a patch
and you basically answer with "Ohh, but we know about that one. Just
apply patch wizzbangfoo#105 which basically does everything differently".

Yeah I'll have a look at that code, and I'll check what the page ages
look like when I actually run it (if it doesn't crash the system first).

Jan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272049AbRIDSD2>; Tue, 4 Sep 2001 14:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272052AbRIDSDR>; Tue, 4 Sep 2001 14:03:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4114 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272049AbRIDSDF>; Tue, 4 Sep 2001 14:03:05 -0400
Date: Tue, 4 Sep 2001 13:37:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904135427.A30503@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0109041332210.2112-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jan Harkes wrote:

> On Tue, Sep 04, 2001 at 12:56:32PM -0300, Marcelo Tosatti wrote:
> > On Tue, 4 Sep 2001, Jan Harkes wrote:
> > > One other observation, we should add anonymously allocated memory to the
> > > active-list as soon as they are allocated in do_nopage. At the moment a
> > > large part of memory is not aged at all until we start swapping things
> > > out.
> > 
> > With reverse mappings we can completly remove the "swap_out()" loop logic
> > and age pte's at refill_inactive_scan(). 
> > 
> > All that with anon memory added to the active-list as soon as allocated,
> > of course.
> > 
> > Jan, I suggest you to take a look at the reverse mapping code. 
> 
> I'm getting pretty sick and tired of these endless discussion. People
> have been reporting problems and they are pretty much alway met with the
> answer, "it works here, if you can do better send a patch".
> 
> Now for the past _9_ stable kernel releases, page aging hasn't worked
> at all!! Nobody seems to even have bothered to check. I send in a patch
> and you basically answer with "Ohh, but we know about that one. Just
> apply patch wizzbangfoo#105 which basically does everything differently".

Jan, 

Calm down. I haven't told you that the reverse mapping code is the fix to
all aging problems, did I?

I will take a careful look at your code later. However, I (and everybody
else) has not enough time to fix the whole VM in one day. 

> Yeah I'll have a look at that code, and I'll check what the page ages
> look like when I actually run it (if it doesn't crash the system first).

I haven't said reverse mapping will fix the aging problem. I just did a
comment on top of your comment.

Please read my mails more carefully and slowly before sending me to
hell. :) 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271503AbRIFRP4>; Thu, 6 Sep 2001 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271502AbRIFRPq>; Thu, 6 Sep 2001 13:15:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:37384 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271498AbRIFRPd>; Thu, 6 Sep 2001 13:15:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 19:22:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Kurt Garloff <garloff@suse.de>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109061356280.31200-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109061356280.31200-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010906171545Z16135-26183+15@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 06:57 pm, Rik van Riel wrote:
> On Thu, 6 Sep 2001, Daniel Phillips wrote:
> 
> > Err, not quite the whole story.  It is *never* right to leave the disk
> > sitting idle while there are dirty, writable IO buffers.
> 
> Define "idle" ?

Idle = not doing anything.  IO queue is empty.

> Is idle the time it takes between two readahead requests
> to be issued, delaying the second request because you
> just moved the disk arm away ?

Which two readahead requests?  It's idle.

> Is idle when we haven't had a request for, say, 3 disk
> seek time periods ?

See above definition of idle.

> Is idle when we won't be getting any request soon for the
> area where the disk arm is hanging out ?  (and how do we
> know the future?)

--
Daniel

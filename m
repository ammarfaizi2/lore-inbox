Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273552AbRIUOXl>; Fri, 21 Sep 2001 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273556AbRIUOXb>; Fri, 21 Sep 2001 10:23:31 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:22797 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273552AbRIUOXT>;
	Fri, 21 Sep 2001 10:23:19 -0400
Date: Fri, 21 Sep 2001 11:23:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.3.96.1010921095055.28645A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33L.0109211121100.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Bill Davidsen wrote:

> The list is an okay way to determine rank within a class, but I still
> think that there is a need for some balance between text, program data,
> pages loaded via i/o, perhaps more. My disquiet with the new
> implementation is based on a desire to avoid swapping program data to make
> room for i/o data (using those terms in a loose way for identification).

Preference for evicting one kind of cache is indeed a bad
thing. It might work for 90% of the workloads, but you can
be sure it breaks horribly for the other 10%.

I'm currently busy tweaking the old 2.4 VM (in the -ac kernels)
to try and get optimal performance from that one, without giving
preference to one kind of cache ... except in the situation where
the amount of cache is excessive.

> I would also like to have time to investigate what happens if the pages
> associated with a program load are handled in larger blocks, meta-pages
> perhaps, which would at least cause many to be loaded at once on a page
> fault, rather than faulting them in one at a time.

This is an interesting thing, too. Something to look into for
2.5 and if it turns out simple enough we may even want to
backport it to 2.4.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


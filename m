Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbRGRVWP>; Wed, 18 Jul 2001 17:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267930AbRGRVWF>; Wed, 18 Jul 2001 17:22:05 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41992 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267933AbRGRVVs>; Wed, 18 Jul 2001 17:21:48 -0400
Date: Wed, 18 Jul 2001 16:50:37 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33L.0107181016500.27454-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0107181648240.8651-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Rik van Riel wrote:

> On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
> 
> > The following patch (against 2.4.6-ac2, already merged in 2.4.6-ac3) adds
> > specific perzone inactive/free shortage handling code.
> 
> Marcelo, now that you have the nice VM statistics
> patch, do you have some numbers on how this patch
> affects the system, 

Yes. 

With the old code, I've seen zone specific shortages which caused the
kernel to free/deactivate pages from all zones.

> or is this patch based on guesswork ?  ;)

Even if I did not had the stats, its senseless to free/deactivate pages
from zones which do not need to.
 
The old behaviour was fundamentally broken.


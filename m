Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRD1NPe>; Sat, 28 Apr 2001 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRD1NPY>; Sat, 28 Apr 2001 09:15:24 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:52850 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S132359AbRD1NPL>; Sat, 28 Apr 2001 09:15:11 -0400
Date: Sat, 28 Apr 2001 16:15:02 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Riccardi <fabio@chromium.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space
Message-ID: <20010428161502.I3529@niksula.cs.hut.fi>
In-Reply-To: <3AEA0C52.FA7CE1F1@chromium.com> <Pine.LNX.4.33.0104281029390.15790-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104281029390.15790-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Apr 28, 2001 at 10:42:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 10:42:29AM +0200, you [Ingo Molnar] claimed:
> 
> per RFC 2616:
> .............
> The Date general-header field represents the date and time at which the
> message was originated, [...]
> 
> Origin servers MUST include a Date header field in all responses, [...]
> .............
> 
> i considered the caching of the Date field for TUX too, and avoided it
> exactly due to this issue, to not violate this 'MUST' item in the RFC. It
> can be reasonably expected from a web server to have a 1-second accurate
> Date: field.
> 
> the header-caching in X15 gives it an edge against TUX, obviously, but IMO
> it's a questionable practice.
> 
> if caching of headers was be allowed then we could the obvious trick of
> sendfile()ing complete web replies (first header, then body).

Uhh, perhaps I'm stupid, but why not cache the date field and update the
field once a five seconds? Or even once a second?

I mean, at the rate of thousands of requests per second that should give you
some advantage over dynamically generating it -- especially if that's the
only thing hindering copletely sendfile()'ing the answer.


-- v --

v@iki.fi

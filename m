Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132850AbRD1Na7>; Sat, 28 Apr 2001 09:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132835AbRD1Nat>; Sat, 28 Apr 2001 09:30:49 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:3187 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S132562AbRD1Nai>; Sat, 28 Apr 2001 09:30:38 -0400
Date: Sat, 28 Apr 2001 16:30:30 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Riccardi <fabio@chromium.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space
Message-ID: <20010428163030.D3682@niksula.cs.hut.fi>
In-Reply-To: <20010428161502.I3529@niksula.cs.hut.fi> <Pine.LNX.4.33.0104281521210.10295-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104281521210.10295-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Apr 28, 2001 at 03:24:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 03:24:25PM +0200, you [Ingo Molnar] claimed:
> 
> On Sat, 28 Apr 2001, Ville Herva wrote:
> 
> > Uhh, perhaps I'm stupid, but why not cache the date field and update
> > the field once a five seconds? Or even once a second?
> 
> perhaps the best way would be to do this updating in the sending code
> itself.
> 
> first there would be a 'current time thread', which updates a global
> shared variable that shows the current time. (ie. no extra system-call is
> needed to access current time.) If the header-sending code detects that
> current time is not equal to the timestamp stored in the header itself,
> then the header is reconstructed. Pretty simple.

Yes, that's vaguely resembles what I had in mind. Of course I had no idea
about the data structures Tux or X15 use internally, so I couldn't think it
too thoroughly.


-- v --

v@iki.fi

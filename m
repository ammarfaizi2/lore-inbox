Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132537AbRD1N0R>; Sat, 28 Apr 2001 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRD1N0H>; Sat, 28 Apr 2001 09:26:07 -0400
Received: from chiara.elte.hu ([157.181.150.200]:48655 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132537AbRD1N0D>;
	Sat, 28 Apr 2001 09:26:03 -0400
Date: Sat, 28 Apr 2001 15:24:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: Fabio Riccardi <fabio@chromium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <20010428161502.I3529@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.33.0104281521210.10295-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Apr 2001, Ville Herva wrote:

> Uhh, perhaps I'm stupid, but why not cache the date field and update
> the field once a five seconds? Or even once a second?

perhaps the best way would be to do this updating in the sending code
itself.

first there would be a 'current time thread', which updates a global
shared variable that shows the current time. (ie. no extra system-call is
needed to access current time.) If the header-sending code detects that
current time is not equal to the timestamp stored in the header itself,
then the header is reconstructed. Pretty simple.

	Ingo


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292206AbSBBDau>; Fri, 1 Feb 2002 22:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292208AbSBBDak>; Fri, 1 Feb 2002 22:30:40 -0500
Received: from adsl-63-197-0-76.dsl.snfc21.pacbell.net ([63.197.0.76]:17679
	"HELO www.pmonta.com") by vger.kernel.org with SMTP
	id <S292206AbSBBDa2>; Fri, 1 Feb 2002 22:30:28 -0500
From: Peter Monta <pmonta@pmonta.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <a3fhh9$u87$1@abraham.cs.berkeley.edu>
	(daw@mozart.cs.berkeley.edu)
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <a3fhh9$u87$1@abraham.cs.berkeley.edu>
Message-Id: <20020202033027.E30BE1C5@www.pmonta.com>
Date: Fri,  1 Feb 2002 19:30:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> However, those aren't the main failure modes you need to be concerned 
> with.  Antenna effects may actually be your biggest problem -- picking 
> up deterministic signals from other parts of the system.

David Wagner wrote:

> For instance, is there a risk that the audio data you read is strongly
> correlated to 60Hz mains noise in some scenarios?  ...

I don't think predictable elements in the audio hurt anything.
So long as there is a noise component, things are fine.

Take the case of a half-full-scale 60 Hz sine wave plus a tiny
bit of noise.  No problem---each sample would still be worth
0.1 bit because the attacker can only guess the 60 Hz part:
subtract this out and you've still got unpredictable noise.
Same deal with crosstalk between channels, so long as it's
reasonably small, say -20 dB or better (as it will be with any
sane sound chip).

> [ audio-entropyd ]

Aha, nothing new under the sun.

Cheers,
Peter Monta

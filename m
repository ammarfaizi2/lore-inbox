Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbRLSVoC>; Wed, 19 Dec 2001 16:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285517AbRLSVnw>; Wed, 19 Dec 2001 16:43:52 -0500
Received: from ca-ol-tours-10-196.abo.wanadoo.fr ([80.8.7.196]:24977 "EHLO
	walhalla.agaha") by vger.kernel.org with ESMTP id <S285516AbRLSVnh>;
	Wed, 19 Dec 2001 16:43:37 -0500
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: Benoit Poulot-Cazajous <poulot@ifrance.com>, nbecker@fred.net,
        linux-kernel@vger.kernel.org
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011217174020.GA24772@0xd6.org>
	<lnitb3drx6.fsf_-_@walhalla.agaha> <20011219175616.GD19236@0xd6.org>
From: Benoit Poulot-Cazajous <Benoit.Poulot-Cazajous@Sun.COM>
Organization: Sun Microsystems
Date: 19 Dec 2001 22:40:39 +0100
In-Reply-To: <20011219175616.GD19236@0xd6.org>
Message-ID: <lnellqevmw.fsf@walhalla.agaha>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. R. Brown" <mrbrown@0xd6.org> writes:

> * Benoit Poulot-Cazajous <poulot@ifrance.com> on Wed, Dec 19, 2001:
> 
> > 
> > But gcc-2.95,x _supports_ "-march=k6", and we should use that instead of
> > "-march-i686".
> > 
> 
> No, k6 != athlon.  IIRC, the i686 optimization is closer to the Athlon than
> the k6 opt.

In theory, you may be right. But gcc-2.95.3 may not follow the theory.

> > before the patch :
> > 1017.92user 261.80system 24:39.89elapsed 86%CPU
> > 706.33user 160.79system 16:23.61elapsed 88%CPU
> > 1787.38user 418.76system 43:35.97elapsed 84%CPU
> > 
> > after the patch :
> > 1018.42user 253.85system 24:44.68elapsed 85%CPU
> > 704.89user 151.76system 16:16.14elapsed 87%CPU
> > 1786.96user 410.76system 43:05.32elapsed 85%CPU
> > 
> > The improvement in system time is nice.
> > 
> 
> Er, there's not much difference...

>From 261.80 to 253.85 => -3%
>From 160.79 to 151.76 => -6%
>From 418.76 to 410.76 => -2%

So the kernel looks between 2 and 6% faster. Not so bad for a one-line
patch ;-)

> Curious, what happens when you compile using gcc 3.0.1 against
> -march=athlon?

Yep, I will try with gcc 3.0.3.

  -- Benoit

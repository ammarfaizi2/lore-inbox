Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRAGXIp>; Sun, 7 Jan 2001 18:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRAGXIf>; Sun, 7 Jan 2001 18:08:35 -0500
Received: from [204.94.214.22] ([204.94.214.22]:21070 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130119AbRAGXIV>; Sun, 7 Jan 2001 18:08:21 -0500
From: "Nathan Scott" <nathans@wobbly.melbourne.sgi.com>
Message-Id: <10101081006.ZM21224@wobbly.melbourne.sgi.com>
Date: Mon, 8 Jan 2001 10:06:36 -0400
In-Reply-To: Daniel Phillips <phillips@innominate.de>
        "Re: More better in mount(2)" (Jan  5,  3:51pm)
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIEPACJAA.law@sgi.com> 
	<10101051142.ZM11680@wobbly.melbourne.sgi.com> 
	<01010503292006.00477@gimli> 
	<10101051340.ZM14895@wobbly.melbourne.sgi.com> 
	<3A55DF78.F92AC570@innominate.de>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: xfs mount opts (was: More better in mount(2))
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Jan 5,  3:51pm, Daniel Phillips wrote:
> Subject: Re: More better in mount(2)
> Nathan Scott wrote:
> > On Jan 5,  3:26am, Daniel Phillips wrote:
> > > ...
> > > This filesystem mount option parsing code is completely ad hoc, and uses
> > > strtok which is horribly horribly broken.  (Do man strtok and read the
> > > 'Bugs' section.)
> > >
> > > It would be worth thinking about how to do this better.
> > 
> > hmm ... can't claim I wrote this code, just looked at it.
> > are you saying the kernel strtok is horribly broken or just
> > the way its being used here?  (and why?)
> 
> >From the man page:
> ...

yup, I did see that.  I've gone through the code and I can't
see anything wrong with it (tell me if I've missed something).
If the problem is simply that its using strtok, then this must
just be a perceived problem rather than an actual problem (the
data is copied, and noone uses it other than the parsing code,
afaict).

>From a look through how the other filesystems do this, it
seems most use strtok (including ext2).

cheers.

-- 
Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

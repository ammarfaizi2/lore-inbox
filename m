Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132550AbRALUhh>; Fri, 12 Jan 2001 15:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRALUhU>; Fri, 12 Jan 2001 15:37:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8455 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132550AbRALUg5>; Fri, 12 Jan 2001 15:36:57 -0500
Message-ID: <3A5F6AD9.8DAD6ABC@transmeta.com>
Date: Fri, 12 Jan 2001 12:36:41 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Andries.Brouwer@cwi.nl, ftpadmin@kernel.org, jmd@foozle.turbogeek.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel.org signer broken?
In-Reply-To: <UTC200101121456.PAA105954.aeb@ark.cwi.nl> <3A5F67D4.D096B191@transmeta.com> <20010112223415.J25659@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
> On Fri, Jan 12, 2001 at 12:23:48PM -0800, H. Peter Anvin wrote:
> > Andries.Brouwer@cwi.nl wrote:
> > > > The signature on man-pages-1.34.tar.gz is bad:
> > >
> > > Hmm, thought I had corrected that already.
> > > Is it correct now?
> > >
> > > Andries
> >
> > Because an updated signature has the same timestamp and size, it can take
> > up to 24 hours for it to hit ftp.kernel.org, and even longer to propagate
> > to the mirrors, unfortunately.
> 
>         Ok, then rsync  won't find it either unless driven in
>         file CRC verification mode (which is not usual...)
> 

Right; kernel.org does that once a day.

>         You *must* change its time (e.g. with touch).
> 

Unfortunately, you can't -- because the signer relies on the timestamp to
know if the file it is mirroring has changed.

Probably the best solution is to touch the original file.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132321AbQKDGSy>; Sat, 4 Nov 2000 01:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132450AbQKDGSo>; Sat, 4 Nov 2000 01:18:44 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57098 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132321AbQKDGSg>;
	Sat, 4 Nov 2000 01:18:36 -0500
Message-ID: <3A03AA33.3D0A61A@mandrakesoft.com>
Date: Sat, 04 Nov 2000 01:18:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Thomas Sailer <sailer@ife.ee.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <Pine.LNX.4.10.10011020937410.1432-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 2 Nov 2000, Thomas Sailer wrote:
> >
> > The OSS API (http://www.opensound.com/pguide/oss.pdf, page 102ff)
> > specifies that a select _with the sounddriver's filedescriptor
> > set in the read mask_ should start the recording.
> 
> So fix the stupid API.
> 
> The above is just idiocy.

We're pretty much stuck with the API, until we look at merging ALSA in
2.5.x.  Broken API or not, OSS is a mature API, and there are
spec-correct apps that depend on this behavior.

(FWIW, ALSA nicely marginalizes its OSS support into a single module, so
that ALSA drivers aren't affected by OSS' ugliness)

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRIDUYG>; Tue, 4 Sep 2001 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbRIDUXz>; Tue, 4 Sep 2001 16:23:55 -0400
Received: from cs666822-222.austin.rr.com ([66.68.22.222]:23430 "EHLO
	igor.taral.net") by vger.kernel.org with ESMTP id <S268916AbRIDUXr>;
	Tue, 4 Sep 2001 16:23:47 -0400
Date: Tue, 4 Sep 2001 15:24:06 -0500
From: Taral <taral@taral.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEVFS_FL_AUTO_DEVNUM on block devices
Message-ID: <20010904152406.A5735@taral.net>
In-Reply-To: <20010904144605.A5496@taral.net> <200109042013.f84KDYD08203@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109042013.f84KDYD08203@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 02:13:34PM -0600, Richard Gooch wrote:
> taral@taral.net writes:
> > 
> > --HlL+5n6rz5pIUxbD
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: inline
> > Content-Transfer-Encoding: quoted-printable
> 
> Please fix your mailer to not send this junk.

It's not junk, it's PGP/MIME. But I disabled it for you.

> You can use the devfs_alloc_major() function to grab a major number
> that won't conflict with another driver. Then use that major when
> calling devfs_register().

Sounds good to me. It might be wise, however, to disable use of
DEVFS_FL_AUTO_DEVNUM in devfs_register with block devices, since it's
not incredibly useful to have two different drivers sharing a major
number.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

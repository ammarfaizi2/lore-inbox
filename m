Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312460AbSDCWwA>; Wed, 3 Apr 2002 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312461AbSDCWvu>; Wed, 3 Apr 2002 17:51:50 -0500
Received: from hera.cwi.nl ([192.16.191.8]:4555 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312460AbSDCWvf>;
	Wed, 3 Apr 2002 17:51:35 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 3 Apr 2002 22:51:31 GMT
Message-Id: <UTC200204032251.WAA510106.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, p_gortmaker@yahoo.com
Subject: Re: [PATCH] omission in video driver
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: Heh, you mean "here is the hardware information, please make a patch".
: But your choice of red makes it truly a "bleeding edge" kernel :)

: The fact that we have been using linux for ~ 10 yrs and nobody has
: complained about the lack of this function yet says something...

: Anyway, have a look at this and see if it is what you had in mind.
: I figured it would be sensible to have a per VC colour

Yes, bleeding edge it was.

Adding something like this is allowed only on April 1st.

[But other systems have it. I find that both FreeBSD and UnixWare
have a KDSBORDER ioctl.]

Yes, your patch sounds more or less OK, but more less than more,
since I think that this should be treated completely parallel
to the palette stuff. And that works as follows:
There are ioctls and escape sequences. Escape sequences set
the palette per-VC. Upon reset the palette is reset to a default.
The default is set by ioctl. (And at the moment the ioctl sets
the default, it is also applied to the actual screen.)

[Not that I like this construction so much, but for uniformity..]
[In fact the author of the palette patch did not know the standard
for escape sequences, but nobody stopped him.]

Andries

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262809AbRE3O2f>; Wed, 30 May 2001 10:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbRE3O2Z>; Wed, 30 May 2001 10:28:25 -0400
Received: from pD9004ADD.dip.t-dialin.net ([217.0.74.221]:13537 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262809AbRE3O2T>;
	Wed, 30 May 2001 10:28:19 -0400
Message-ID: <3B150369.D47ED28F@pcsystems.de>
Date: Wed, 30 May 2001 16:27:53 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
In-Reply-To: <Pine.LNX.4.33.0105301559310.1240-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > less code / one int more in the kernel
> > or
> > more code and #ifs / one int less in the kernel
>
> if the #ifdefs bloat the code 4 times the size of the simple patch, then
> we obviously want 4 bytes more in the kernel.

Okay.

> > And what about the code from kernel/sys.c ? The version you provided
> > doesn't take care of what's the default value of pcspeaker. This would
> > make it undefined, which is not really good.
>
> the default value is 0, that is good enough.

hmm.. I don't think so... value of 1 would be much better, because
0 normally disables the speaker.
So setting somewhere pcspeaker_enabled = 1 should be better
than having it with 0.

So in kernel/sysctl.c:

int pcspeaker_enabled = 1;

or anybody against this ?

Nico



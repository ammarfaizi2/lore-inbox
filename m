Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135892AbREBUwK>; Wed, 2 May 2001 16:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135916AbREBUwB>; Wed, 2 May 2001 16:52:01 -0400
Received: from chromium11.wia.com ([207.66.214.139]:42763 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S135782AbREBUvz>; Wed, 2 May 2001 16:51:55 -0400
Message-ID: <3AF07459.8D8ECD8E@chromium.com>
Date: Wed, 02 May 2001 13:55:53 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org> <200104292116.f3TLGhu07016@pachyderm.pa.dec.com> <20010502211800.X805@mea-ext.zmailer.org> <9cpnfj$ms3$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my experience system calls are not an issue.

What costs a lot is moving data around, since modern CPUs spend most of their
time in memory/bus wait cycles...

 - Fabio

Linus Torvalds wrote:

> >I think that applies to all really high-performance servers.
>
> Note that it is definitely not always true.
>
> Linux system calls are reasonably light-weight.  And sometimes trying to
> avoid them ends up beaing _more_ work - because you might have to worry
> about synchronization and cache coherency in user mode.
>
> So the rule should be "avoid _unnecessary_ system calls".
>
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTKEWe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTKEWe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:34:28 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:15488
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263269AbTKEWe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:34:28 -0500
Date: Wed, 5 Nov 2003 17:33:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
In-Reply-To: <20031105222302.GA12992@work.bitmover.com>
Message-ID: <Pine.LNX.4.53.0311051733310.6824@montezuma.fsmlabs.com>
References: <20031105204522.GA11431@work.bitmover.com>
 <20031105125813.A5648@one-eyed-alien.net> <20031105222302.GA12992@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Nov 2003, Larry McVoy wrote:

> On Wed, Nov 05, 2003 at 12:58:13PM -0800, Matthew Dharm wrote:
> > Out of curiosity, what were the changed lines?
> 
> --- GOOD        2003-11-05 13:46:44.000000000 -0800
> +++ BAD 2003-11-05 13:46:53.000000000 -0800
> @@ -1111,6 +1111,8 @@
>                 schedule();
>                 goto repeat;
>         }
> +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> +                       retval = -EINVAL;

That looks odd


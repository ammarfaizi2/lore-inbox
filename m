Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVC1UoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVC1UoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVC1UoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:44:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26120 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261644AbVC1UoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:44:14 -0500
Date: Mon, 28 Mar 2005 22:44:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Renate Meijer <kleuske@xs4all.nl>
Cc: folkert@vanheusden.com, linux-kernel@vger.kernel.org
Subject: [BORED] Re: forkbombing Linux distributions
Message-ID: <20050328204411.GX30052@alpha.home.local>
References: <20050328172820.GA31571@linux.ensimag.fr> <20050328175614.GG943@vanheusden.com> <Pine.LNX.4.61.0503282131560.11428@yvahk01.tjqt.qr> <20050328193933.GH943@vanheusden.com> <a1212af498cc4d77373b7be0db524347@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1212af498cc4d77373b7be0db524347@xs4all.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please,

would you be so kind to stop debugging your fork-bombing tools with all
the list in CC ? I think that most of us are not interested in knowning
whether the cast is necessary or not before the malloc(). This is LKML,
not FBTML. There are lots of ways to locally DoS linux, you don't need
to fine tune your tools here in public.

Thanks in advance,
Willy

On Mon, Mar 28, 2005 at 10:35:00PM +0200, Renate Meijer wrote:
> 
> On Mar 28, 2005, at 9:39 PM, folkert@vanheusden.com wrote:
> 
> On Mar 28, 2005, at 9:39 PM, folkert@vanheusden.com wrote:
> 
> >>I already posted one, posts ago.
> >>>>[snip]
> >>>Imporved version:
> >>>[snip]
> >>>char *dummy = (char *)malloc(1);
> >>That cast is not supposed to be there, is it? (To pretake it: it's 
> >>bad.)
> >
> >What is so bad about it?
> 
> Read the FAQ at http://www.eskimo.com/~scs/C-faq/q7.7.html
> 
> Malloc() returns a void*, so casts are superfluous if stdlib.h is 
> included (as it should be). Hence if one typecasts the result of malloc 
> in order to suit any particular type, the real bug is probably a 
> lacking "#iinclude <stdlib.h>", which the cast (effectively) is hiding.
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

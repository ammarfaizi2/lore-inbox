Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268047AbTBYQIu>; Tue, 25 Feb 2003 11:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268055AbTBYQIu>; Tue, 25 Feb 2003 11:08:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268047AbTBYQI3>; Tue, 25 Feb 2003 11:08:29 -0500
Date: Tue, 25 Feb 2003 08:15:40 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Schwab <schwab@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <Pine.LNX.4.44.0302250742400.10210-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302250811220.10500-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, Linus Torvalds wrote:
>
> 		return x[1][-1];

Btw, don't get me wrong. I don't think the above is really code that 
should survive, and if the compiler were to generate a warning for 
something like that, where the subscripts are clearly out of the range 
that they were in the declaration, then I'd be entirely supportive of 
that.

I don't know how we got side-tracked to negative subscripts. They are 
clearly legal with pointers, but that wasn't even the issue: the code that 
generated the "signed/unsigned" warning didn't use any negative 
subscripts, never had, and never will.

And unlike the abomination above, the code that generates the warning is 
the _clearest_ version of code you can humanly write. And THAT is the 
problem with the warning: there's no way to avoid the warning without 
making the source code _worse_ in some way.

And _that_ is what my argument really boils down to. Nothing else.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTBXWYB>; Mon, 24 Feb 2003 17:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBXWYB>; Mon, 24 Feb 2003 17:24:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49168 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261456AbTBXWYA>; Mon, 24 Feb 2003 17:24:00 -0500
Date: Mon, 24 Feb 2003 14:28:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Schwab <schwab@suse.de>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <jeznol5plv.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0302241426480.13406-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Feb 2003, Andreas Schwab wrote:
> |> 
> |> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
> 
> How can you distinguish that from other occurrences of (int)<(size_t)?

Which is indeed my point. If you cannot distinguish it from incorrect
uses, you shouldn't be warnign the user, because the compiler obviously
doesn't know enough to make a sufficiently educated guess.

That said, a good compiler _can_ make a good warning. But to do so, you 
have to actually do value analysis, instead of just blindly warning about 
code that is obviously correct to a human.

Until gcc does sufficient value analysis, that signed warning is annoying,
worthless and a damn pain in the ass.

			Linus


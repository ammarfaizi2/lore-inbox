Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbTE1QOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbTE1QOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:14:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35599 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264791AbTE1QOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:14:42 -0400
Date: Wed, 28 May 2003 09:14:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.LNX.3.96.1030528115243.19675A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0305280909550.8790-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 May 2003, Bill Davidsen wrote:
> 
> Just the other day you posted strong opposition to breaking existing
> binaries, how does that map with breaking existing hardware?

One fundamental difference is that I cannot fix it without people who
_have_ the hardware caring. So if they don't care, I don't care. It's that
easy. If you want to have your hardware supported, you need to help
support it.

Another difference is that it's better to not work at all, than to work
incorrectly. So if your kernel doesn't boot or can't use your random piece
of hardware, you just use an old kernel. But if everything looks normal,
but some binary breaks in strange ways, that's _bad_.

The latter reason is, btw, why we don't paper over the build failures like 
some people suggested. If it hasn't been updated to the new interfaces, it 
should preferably not even build: which is a big reason why we try to 
rename interfaces when they change, exactly so that you don't get a subtly 
broken build.

		Linus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbRLGR7P>; Fri, 7 Dec 2001 12:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282893AbRLGR7G>; Fri, 7 Dec 2001 12:59:06 -0500
Received: from ns.suse.de ([213.95.15.193]:38152 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282878AbRLGR6s>;
	Fri, 7 Dec 2001 12:58:48 -0500
Date: Fri, 7 Dec 2001 18:58:47 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
Message-ID: <20011207185847.A20876@wotan.suse.de>
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de> <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can be thread-safe without sucking dead baby donkeys through a straw.
> I already mentioned two possible ways to fix it so that you have locking
> when you need to, and no locking when you don't.

Your proposals sound rather dangerous. They would silently break recompiled
threaded programs that need the locking and don't use -D__REENTRANT (most
people do not seem to use it). I doubt the possible pain from that is 
worth it for speeding up an basically obsolete interface like putc. 

i.e. if someone wants speed they definitely shouldn't use putc()

-Andi

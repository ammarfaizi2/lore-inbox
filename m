Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbTFLDoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 23:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbTFLDoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 23:44:06 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:5336 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264710AbTFLDoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 23:44:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.59032.405790.988082@gargle.gargle.HOWL>
Date: Wed, 11 Jun 2003 22:34:00 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       bos@serpentine.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] as-iosched divide by zero fix
In-Reply-To: <3EE7D7F5.3070803@cyberone.com.au>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	<20030611154122.55570de0.akpm@digeo.com>
	<1055374476.673.1.camel@localhost>
	<1055377120.665.6.camel@localhost>
	<20030611172444.76556d5d.akpm@digeo.com>
	<1055380257.662.8.camel@localhost>
	<20030611182249.0f1168e4.akpm@digeo.com>
	<3EE7D7F5.3070803@cyberone.com.au>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick> Yeah, thats the way to do it, of course. It was too jumpy at
Nick> that setting though, so make it batch*3 (or <<1+batch if you
Nick> don't want the multiply).

Aren't we trying to get away from magic constants like this?  Or at
least a better idea of why batch*3 is better than batch*2?  I will
admit I haven't had the chance to peer into the code, so I'm probably
just being stupid (and lazy) here to speak up.

I guess the real question I have is what happens if we make it
batch*100, how does the affect the algorithm?  And if going from 2 to
3 makes such a difference, doesn't that point to a scaling issue,
i.e. we should have 200 and 300 here, so we can try out 250 as an
intermediate value.

*shrug* Just trying to understand...

John

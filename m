Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbULTJJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbULTJJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbULTJJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:09:11 -0500
Received: from webmail.sub.ru ([213.247.139.22]:13585 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261287AbULTJIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:08:53 -0500
Message-ID: <21322.195.133.60.161.1103533647.squirrel@195.133.60.161>
In-Reply-To: <20041219231250.457deb12.akpm@osdl.org>
References: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1>
    <20041219231250.457deb12.akpm@osdl.org>
Date: Mon, 20 Dec 2004 12:07:27 +0300 (MSK)
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
From: mr@ramendik.ru
To: "Andrew Morton" <akpm@osdl.org>
Cc: lista4@comhem.se, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       mr@ramendik.ru, kernel@kolivas.org, riel@redhat.com
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Did anyone come up with a simple step-by-step procedure for reproducing
> the
> problem?  It would be good if someone could do this, because I don't think
> we understand the root cause yet?

Here's a step-by-step explanation of the way I test this:

- Get the Memory Eater and compile it:

http://lkml.org/lkml/2004/12/13/272

- Do a clean boot

- Start top, and some app that has a clock and preferrably a CPU graph (to
monitor screen freezes and CPU load; it's IceWM for me)

- Start the Memory Eater

- Give it an amount of megabytes that is more than the actual RAM size. I
use a value of 300, as my computer has 256 M RAM.

- Enjoy :) "eatmemory" will slowly eat up more and more RAM (visible in
top as RSS); under 2.6.8.1 no screen freezes come, and under 2.6.9 and
2.6.10-rc3 they do come; under 2.6.10-rc3 I also see high CPU periods for
kswapd.

Yours, Mikhail Ramendik






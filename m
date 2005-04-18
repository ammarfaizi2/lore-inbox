Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVDRH4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVDRH4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVDRH4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:56:55 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:49290 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261863AbVDRH4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:56:48 -0400
X-ORBL: [67.124.119.21]
Date: Mon, 18 Apr 2005 00:56:35 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418075635.GB644@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42636285.9060405@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 04:32:21PM +0900, Takashi Ikebe wrote:

> The software does not allow to stops over 100 milliseconds at worst
> case.

Out of interest, how do you ensure the process doesn't stop for that
long right now?  Linux doesn't guarantee you'll get scheduled
(strictly speaking) in n milliseconds usually.

> Not to descent the service availability, software fix due to bug,
> should not stop the service, and live patching is very historical
> function in telecoms world.

Lots of really complicated and unnecessary things are common in the
telecoms world.

For the example you gave I can think of several ways to migrate data
to a new process (if need be) in a timely manner without interruption.
None of these *require* live patching.

> Every carrier, NEPs(Network Equipment Provider) provide/use this
> function to keep network service (such as telephone) available.

How does this *require* live patching?

> This function is very essential whenever the carrier use the linux
> as center of it's system.

Those are just marketing words.

> Therefore the live patching function should not stop the target
> process (service process) as possible as. the more times we stop the
> target process, the service goes unavailable...

Love patching seems like a very complicated thing to get right and it
could potentially blow up.

I'm guessing any suggestion of fixing the applications behavior would
be lost with some argument along the lines of: "this application was
written in 1824 by Ada Lovelace using pre-Roswell Alien Technology and
was certified NEBS compliant by the Deli Lama and god herself, so
clearly we can't touch a single line of it" or similar right?

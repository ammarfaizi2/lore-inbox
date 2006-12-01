Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031656AbWLARkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031656AbWLARkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759308AbWLARkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:40:46 -0500
Received: from 1wt.eu ([62.212.114.60]:13573 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1759281AbWLARkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:40:46 -0500
Date: Fri, 1 Dec 2006 18:40:35 +0100
From: Willy Tarreau <w@1wt.eu>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] missing parenthesis
Message-ID: <20061201174035.GA18203@1wt.eu>
References: <200612011510.58990.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612011510.58990.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mariusz,

Thanks for your work at fixing all this code. I'm wondering though,
given the type of errors, this code should never have been able to
build at all, so that means that it might not be used at all.

As a general rule of thumb, keep in mind that we're not much tempted
to fix known unused code, especially if it's unmaintained. The reason
is simple : when some code does not work, people who need it often
maintain patches in their tree to make it work. When we start changing
things there, their patches often apply with rejects. Anyway, *I* am
still for a clean kernel because I know that there's nothing more
annoying than spending days chasing a bug which we discover was known
for years.

So what I can propose you is that we :
  - postpone those patches for 2.4.35-pre
  - ask maintainers of each of these files if he accepts to fix the
    file, because some of them are totally against any such change.
  - we would merge the accepted patches and those without any reply
    which we consider relevant early in the 35-pre cycle so that
    people have some time to inform us about the potential conflicts
    they encounter.

Quite frankly, there should be very few problems, considering that we
have affected more files with the gcc4 patches and that nobody
complained.

As an exception, if you get some maintainer's approval for some of
the patches during 2.4.34 cycle, of course I will merge them first
because as I said, it's important to maintain supported code in good
shape.

Is it OK for you ?

Regards,
Willy


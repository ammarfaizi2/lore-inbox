Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270466AbRIBJV4>; Sun, 2 Sep 2001 05:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270480AbRIBJVq>; Sun, 2 Sep 2001 05:21:46 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:31659 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S270466AbRIBJVa>;
	Sun, 2 Sep 2001 05:21:30 -0400
Message-Id: <m15dTRm-000QCGC@amadeus.home.nl>
Date: Sun, 2 Sep 2001 10:21:42 +0100 (BST)
From: arjan@fenrus.demon.nl
To: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.10-pre3 - bug report
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109020348.f823mCs01183@penguin.transmeta.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200109020348.f823mCs01183@penguin.transmeta.com> you wrote:
> These are bounce buffer allocations - they do fail, but the failures
> should be temporary and the machine should make progress. 

The patch I sent to linux-mm a week ago fixes this for "normal" loads.
It obviously doesn't fix the worst case scenario, but in the testing in the
Red Hat lab we've seen it 1) improve performance and 2) get rid of VM
problems caused by highmem; under normal load. Under the insane load we also
put our kernels on, it doesn't make much difference, the obvious deadlock is
still there.

Greetings,
    Arjan van de Ven

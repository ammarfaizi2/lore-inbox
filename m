Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRIDUWG>; Tue, 4 Sep 2001 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRIDUVz>; Tue, 4 Sep 2001 16:21:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44046 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268940AbRIDUVp>; Tue, 4 Sep 2001 16:21:45 -0400
Subject: Re: page_launder() on 2.4.9/10 issue
To: jaharkes@cs.cmu.edu (Jan Harkes)
Date: Tue, 4 Sep 2001 21:25:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <20010904153958.A31994@cs.cmu.edu> from "Jan Harkes" at Sep 04, 2001 03:39:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15eMl6-0004Rn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pages allocated with do_anonymous_page are not added to the active list.
> as a result there is no aging information for a page until it is
> unmapped. So we might be unmapping and allocating swap for shared pages

Right ok. 

> I guess it is just more carefully papering over the existing problems.

If you are correct then I suspect the better behaviour is primarily coming
from the balancing algorithms and the choices made rather than the quality
of data suggested.

When Rik gets back off a plane this sounds like something that should be
tested - one item at a time.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272570AbTHFVof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272578AbTHFVof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:44:35 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12425 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272570AbTHFVob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:44:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 23:44:21 +0200 (MEST)
Message-Id: <UTC200308062144.h76LiLm16781.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, jgarzik@pobox.com
Subject: Re: Add identify decoding 4/4
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know full well _why_ the big function is in the header;
> that doesn't address my point:  we don't need to be putting
> big functions in header files.  That's why libraries were invented

Well. I chose the most elegant solution I saw.

If you see a better solution, I would like to see it.
Note that local symbols in several files determine
whether this function should be compiled or not.

Also, consider the following.
This file *is* a library. It contains a hundred
(in the version you saw half a dozen) one-line
static inline functions. That is the real library.
It describes all identify stuff.
And there is a single large function used for debugging,
invisible unless a debugging symbol is defined.

I cannot see anything wrong with that.
You are very narrow minded if you are blinded by the
fact that the name ends in an h.

Andries

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274885AbTHFHJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274887AbTHFHJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:09:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:11660 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S274885AbTHFHJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:09:44 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 09:09:43 +0200 (MEST)
Message-Id: <UTC200308060709.h7679hO01041.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] fix error return get/set_native_max functions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Giant patch? :( Can you split it?

Of course.

A moment ago I split off the third part. More will follow.
(1 was bookkeeping in sector_t, 2 was addr++ fix).

This third part takes code that was repeated three times,
namely a debugging printout of the IDENTIFY DEVICE result,
and leaves only a single copy, that moreover is a bit more correct.

One of the things that were wrong in the debugging part
is also wrong in the non-debugging part, namely the ordering
of the bitfields on a bigendian architecture.
Probably that will be the next installment.

Let me send this in four subparts.
Three parts that remove the debugging code, and one part
that adds a single copy, in a new file ide-identify.h
that contains stuff that will also correct and simplify
other code.

Andries

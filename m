Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275118AbTHRWBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275126AbTHRWBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:01:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:33751 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275118AbTHRWBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:01:14 -0400
Date: Mon, 18 Aug 2003 14:57:09 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andries.Brouwer@cwi.nl
Cc: Dominik.Strasser@t-online.de, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: headers
Message-Id: <20030818145709.0b5e162a.rddunlap@osdl.org>
In-Reply-To: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
References: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 21:07:44 +0200 (MEST) Andries.Brouwer@cwi.nl wrote:

|     From garzik@gtf.org  Mon Aug 18 20:14:47 2003
| 
|     I support include/abi, or some other directory that segregates
|     user<->kernel shared headers away from kernel-private headers.
| 
|     I don't see how that would be auto-generated, though.  Only created
|     through lots of hard work :)
| 
| Yes, unfortunately. I started doing some of this a few times,
| but it is an order of magnitude more work than one thinks at first.

I expected that.

| Already the number of include files is very large.
| And the fact that it is not just include/abi but involves the architecture
| doesn't make life simpler.
| 
| No doubt we must first discuss a little bit, but not too much,
| the desired directory structure and naming.
| Then we must do 5% of the work, and come back to these issues.
| 
| In case people actually want to do this, I can coordinate.
| 
| In case people want to try just one file, do signal.h.

Hm, interesting.

Since there are 20+ <arch>/signal.h files and they don't always agree
on signal bit numbers e.g., do we have 20+ abi/arch/signal.h files?
Or 1 abi/signal.h file with many #ifdefs?  ugh.

The ABI is still per-arch, right?  Not _one ABI_ for any/all arches.

Or maybe I'm all wet.

--
~Randy
"Everything is relative."

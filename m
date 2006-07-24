Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWGXIGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWGXIGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGXIGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:06:45 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:43200 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932090AbWGXIGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:06:45 -0400
Message-ID: <44C47ECF.5090500@s5r6.in-berlin.de>
Date: Mon, 24 Jul 2006 10:03:27 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
CC: Michael Buesch <mb@bu3sch.de>, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Lindent cleanup (was Re: [PATCH] drivers: Conversions from kmalloc+memset
 to k(z|c)alloc.)
References: <44C099D2.5030300@s5r6.in-berlin.de> <20060723112005.GA6815@martell.zuzino.mipt.ru> <Pine.BSO.4.63.0607231929350.10018@rudy.mif.pg.gda.pl> <200607232024.43237.mb@bu3sch.de> <Pine.BSO.4.63.0607240116020.10018@rudy.mif.pg.gda.pl> <Pine.BSO.4.63.0607240237030.10018@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.63.0607240237030.10018@rudy.mif.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz K³oczko wrote:
> On Mon, 24 Jul 2006, Tomasz K³oczko wrote:
> [..]
>> In all other/most of cases (probably ~99%) Lindetd can be used .. but for NOW 
>> GENERALY IT IS NOT NOT USED.
> 
> I'm just look on number changed fles by Lindent. diffstat shows 14593 
> changed files. Number of all *.[ch] files is 16028. So it shows now 
> ~9% all files passes cleanly indentation using Lindent (my above 
> "GENERALY IT IS NOT NOT USED" isn't true :).

You already posted a good step-by-step proposal. I suggest another
slightly different approach:

People who are interested to help out should just go systematically
through subsystems and drivers, run them through Lindent, check and
perhaps beautify the output, and submit the resulting patches in a form
and to the appropriate addresses as usual (i.e. sensibly broken-up
patches, submitted to subsystem mailinglists and maintainers).

Whenever manual corrections after Lindent were necessary and whenever
there will be objections by reviewers to Lindent's results, take this
feedback as input for the two discussions about
 - consensus about preferred style, i.e. refinement of CodingStyle,
 - possible improvements of Lindent.
These discussions should of course take place at LKML instead of
subsystem mailinglists.

> IMO it is sill possible add general rule "allways use Lindent" because 
> indent can be dissabled/enabled aroud code inccorectly formated by add 
> control comments like:
> 
> /* *INDENT-OFF* */
> /* *INDENT-ON* */
> 
> If it will be widely used probably it will allow better identify some 
> indent problems.

IMHO: Write code for cpp, cc, as --- but not for any other
processor-de-jour. All those processors (formatters, checkers etc.) are
fine to *inspect* code for formal or semantic problems. But this should
not lead to thousands more or less obscure processor keywords sprinkled
all over the sources --- bloating them and making them confusing.
-- 
Stefan Richter
-=====-=-==- -=== ==---
http://arcgraph.de/sr/

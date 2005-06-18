Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVFRSKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVFRSKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 14:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVFRSKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 14:10:31 -0400
Received: from smtp2gate.fmi.fi ([193.166.223.32]:64222 "EHLO smtp2gate.fmi.fi")
	by vger.kernel.org with ESMTP id S262170AbVFRSHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 14:07:30 -0400
Message-Id: <200506181806.j5II6otS019215@leija.fmi.fi>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
In-Reply-To: <200506181804.21366.robin.rosenberg.lists@dewire.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Date: Sat, 18 Jun 2005 21:06:50 +0300 (EEST)
From: Kari Hurtta <hurtta+linux-kernel@leija.mh.fmi.fi>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Richard B. Johnson" <linux-os@analogic.com>,
       Lukasz Stelmach <stlman@poczta.fm>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
X-Mailer: ELM [version 2.4ME+ PL121+test20050529 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Filter: smtp2gate: ID 27277/01, 1 parts scanned for known viruses
X-Filter: torkku: ID 0193/01, 1 parts scanned for known viruses
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fredagen den 17 juni 2005 15.23 skrev Måns Rullgård:
> > Some characters can be encoded in several equally shortest ways.  
> 
> No they cannot. How to encode characters i explicitly and well defined. If you 
> don't follow the rules you are simply not producing UTF-8, but something 
> else.
> 
> Every unicode character has exactly one  UTF-8 representation. 
> 
> -- robin

You are confused between unicode characters and unicode codepoints.

Every unicode codepoint has exactly one  UTF-8 representation.

Unicode characters may use one ore more unicode codepoints.

Some characters have also representation with one codepoint, but not all.

For example

	LATIN CAPITAL LETTER A WITH ACUTE

have presentation	0041 0301

That is two unicode codepoints.  That character
have also other (compatibility) representation

that is			00C1


But consider (somewhat imaginary) character

	LATIN CAPITAL LETTER A WITH GRAVE AND CIRCUMFLEX

that have presentation	0041 0300 0302

but it have also presentation	0041 0302 0300


Both presentations are equal short.



/ Kari Hurtta	



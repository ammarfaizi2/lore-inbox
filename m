Return-Path: <linux-kernel-owner+w=401wt.eu-S932092AbXACUbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbXACUbG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbXACUbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:31:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47665 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096AbXACUbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:31:04 -0500
Date: Wed, 3 Jan 2007 12:24:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: l.genoni@oltrelinux.com, Grzegorz Kulewski <kangur@polcom.net>,
       Alan <alan@lxorguk.ukuu.org.uk>, Mikael Pettersson <mikpe@it.uu.se>,
       s0348365@sms.ed.ac.uk, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <Pine.LNX.4.63.0701031831160.29878@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.64.0701031212070.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <20070103102944.09e81786@localhost.localdomain> <Pine.LNX.4.63.0701031128420.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0701030731080.4473@woody.osdl.org>
 <Pine.LNX.4.64.0701031759030.8415@Phoenix.oltrelinux.com>
 <Pine.LNX.4.63.0701031831160.29878@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Tim Schmielau wrote:
>
> Well, on a P4 (which is supposed to be soo bad) I get:

Interesting. My P4 gets basically exactly the same timings for the cmov 
and branch cases.  And my Core 2 is consistently faster (something like 
15%) for the branch version.

Btw, the test-case should be the best possible one for cmov, since there 
are no data-dependencies except for ALU operations, and everything is 
totally independent (the actual values have no data dependencies at all, 
since they are constants). So the critical path issue never show up.

		Linus

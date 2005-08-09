Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVHIEkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVHIEkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVHIEkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:40:23 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:24301 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932446AbVHIEkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:40:23 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Daniel Phillips <phillips@arcor.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200508090710.00637.phillips@arcor.de>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123562392.4370.112.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 14:39:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-08-09 at 07:09, Daniel Phillips wrote:
> > It doesn't look like they'll be able to easily free up a page
> > flag for 2 reasons. First, PageReserved will probably be kept
> > around for at least one release. Second, swsusp and some arch
> > code (ioremap) wants to know about struct pages that don't point
> > to valid RAM - currently they use PageReserved, but we'll probably
> > just introduce a PageValidRAM or something when PageReserved goes.

Changing the e820 code so it sets PageNosave instead of PageReserved,
along with a couple of modifications in swsusp itself should get rid of
the swsusp dependency.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


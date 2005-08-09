Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVHIBdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVHIBdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 21:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVHIBdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 21:33:20 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:44423 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932399AbVHIBdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 21:33:20 -0400
Subject: Re: [PATCH 2/4] Task notifier: Implement todo list in task_struct
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Lameter <christoph@lameter.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507281456240.14677@graphe.net>
References: <200507260340.j6Q3eoGh029135@shell0.pdx.osdl.net>
	 <Pine.LNX.4.62.0507272018060.11863@graphe.net>
	 <20050728074116.GF6529@elf.ucw.cz>
	 <Pine.LNX.4.62.0507280804310.23907@graphe.net>
	 <20050728193433.GA1856@elf.ucw.cz>
	 <Pine.LNX.4.62.0507281251040.12675@graphe.net>
	 <Pine.LNX.4.62.0507281254380.12781@graphe.net>
	 <20050728212715.GA2783@elf.ucw.cz> <20050728213254.GA1844@elf.ucw.cz>
	 <Pine.LNX.4.62.0507281456240.14677@graphe.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123551167.9451.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Aug 2005 11:32:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Just to let you know that I have it working with Suspend2. One thing I
am concerned about is that we still need a way of determining whether a
process has been signalled but not yet frozen. At the moment you just
check p->todo, but if/when other functionality begins to use the todo
list, this will be unreliable.

I'm happy to supply the patches I'm using if you want to compare. (I
retained the other freezer improvements, so it wouldn't just be bug
fixes against your patches).

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbTHaJOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 05:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHaJOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 05:14:09 -0400
Received: from AMontsouris-108-1-16-60.w80-15.abo.wanadoo.fr ([80.15.145.60]:22400
	"EHLO paldrick.research.newtrade.nl") by vger.kernel.org with ESMTP
	id S262275AbTHaJOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 05:14:08 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab call trace
Date: Sun, 31 Aug 2003 11:15:24 +0200
User-Agent: KMail/1.5.1
Cc: Fredrik Noring <noring@nocrew.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0308302248230.20207-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0308302248230.20207-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308311115.24188.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My feeling is that a reasonably large change may end up being the best
> thing to do.  In particular, we probably only need to have one QH per
> queue, instead of one for each URB.  But it'll be a while before that
> stuff gets done.

But won't that result in starvation of some endpoints in favour of those
with vast numbers of urbs queued on them?  At the moment the per-urb
QHs mean that the hc works on only one urb per endpoint before moving
on to the next endpoint.

Ciao,

Duncan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTLJB25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTLJB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:28:57 -0500
Received: from ssatchell1.pyramid.net ([208.170.252.115]:21647 "EHLO
	ssatchell1.pyramid.net") by vger.kernel.org with ESMTP
	id S263325AbTLJB2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:28:53 -0500
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
From: Stephen Satchell <list@satchell.net>
To: Dominik Kubla <dominik@kubla.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FD62845.8090301@kubla.de>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
	 <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>
	 <1070975964.5966.5.camel@ssatchell1.pyramid.net>
	 <Pine.LNX.4.53.0312090854080.8425@chaos>
	 <1070981185.6243.58.camel@ssatchell1.pyramid.net>
	 <Pine.LNX.4.53.0312091014250.525@chaos>  <3FD62845.8090301@kubla.de>
Content-Type: text/plain
Message-Id: <1071019731.8045.31.camel@ssatchell1.pyramid.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 17:28:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-09 at 11:53, Dominik Kubla wrote:
> Richard B. Johnson wrote:
> > If you need statistics v.s. time, you need to write an application
> > that samples things at some fixed interval. In a previous life,
> > I requested that "nr_free_pages()" be accessible from user-space,
> > probably via /proc. That's all you need. Maybe that could be
> > added now?  In any event, samping free pages at some fixed-time
> > interval should give you all the information you need.
> 
> vmstat -a
> sar -B
> sar -r
> 
> O'Reilly's "System Performance Tuning" might make for an interesting read,
> especially pages 110ff (also its Linux informations are a bit out of date).

How does sampling free pages give you an accurate measurement of swap
activity?  If I look at the free-page count at one-minute intervals, the
system can, and WILL, inhale and exhale pages at a frightening clip, and
there is no way I can see that sampling free-page count in a
low-overhead way will do the trick.

How does vmstat disk-swap activity?  Looking at the source for vmstat in
procps-2.0.11 I see how they do it for 2.4 kernels, but the part for 2.5
kernels doesn't seem to try to pick up swap statistics at all -- because
there are none to get?

(signed) Puzzled.

(Why does this whole discussion remind me of the Firesign Theatre album
_I Think We're All Bozos On This Bus_, and the question that Ah Clem
asked:  "Why does the porridge-bird lay his eggs in the air?")


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVAGXtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVAGXtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVAGXtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:49:41 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59110 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261700AbVAGXrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:47:12 -0500
Message-ID: <41DF1F3D.3030006@nortelnetworks.com>
Date: Fri, 07 Jan 2005 17:46:05 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
References: <41DE9D10.B33ED5E4@tv-sign.ru> <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org> <1105113998.24187.361.camel@localhost.localdomain> <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org> <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
In-Reply-To: <41DEF81B.60905@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:

> This got me to thinking about how you can heuristically optimize away
> coalescing support and still allow PAGE_SIZE bytes minimum in the
> effective buffer.

While coalescing may be a win in some cases, there should also be some 
way to tell the kernel to NOT coalesce, to handle the case where you 
want minimum latency at the cost of some throughput.

Chris

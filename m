Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVBGXnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVBGXnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVBGXnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:43:14 -0500
Received: from embeddededge.com ([209.113.146.155]:32524 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S261345AbVBGXnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:43:05 -0500
In-Reply-To: <1107812101.7734.42.camel@gaston>
References: <41FECA18.50609@nortelnetworks.com> <1107243398.4208.47.camel@laptopd505.fenrus.org> <41FFA21C.8060203@nortelnetworks.com> <1107273017.4208.132.camel@laptopd505.fenrus.org> <20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com> <1107595148.30302.5.camel@gaston>  <42077EE0.2060505@nortel.com> <1107812101.7734.42.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bc4f2e60770528d4934b5a2e69285002@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Chris Friesen <cfriesen@nortel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: question on symbol exports
Date: Mon, 7 Feb 2005 18:42:24 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 7, 2005, at 4:35 PM, Benjamin Herrenschmidt wrote:

> Interesting... more than no swap, you must also make sure you have no
> r/w mmap'ed file (which are technically equivalent to swap).

Yeah, I kinda had a similar thought.  Just because you aren't
swapping doesn't mean the VM subsystem isn't looking at dirty bits,
too.  It could potentially steal a page that it thinks can be replaced
from either a zero-fill or reading again from persistent storage.


	-- Dan


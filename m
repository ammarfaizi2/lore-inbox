Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVBGXDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVBGXDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 18:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBGXDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 18:03:23 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1492 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261343AbVBGXDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 18:03:08 -0500
Message-ID: <4207F396.7080408@nortel.com>
Date: Mon, 07 Feb 2005 17:02:46 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: question on symbol exports
References: <41FECA18.50609@nortelnetworks.com>	 <1107243398.4208.47.camel@laptopd505.fenrus.org>	 <41FFA21C.8060203@nortelnetworks.com>	 <1107273017.4208.132.camel@laptopd505.fenrus.org>	 <20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com>	 <1107595148.30302.5.camel@gaston>  <42077EE0.2060505@nortel.com> <1107812101.7734.42.camel@gaston>
In-Reply-To: <1107812101.7734.42.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Interesting... more than no swap, you must also make sure you have no
> r/w mmap'ed file (which are technically equivalent to swap).

Ah...thanks for the warning.

We want to eventually make it work with swap as well, but that's 
substantially more complicated.

> I'm not too fan about exporting those symbols, but I'll talk to paulus,
> it should be possible at least to EXPORT_SYMBOL_GPL them...

I understand the reluctance.  I'm perfectly willing to export it GPL in 
my private branch as long as you guys don't consider it evil--the module 
is going to be GPL anyways.

The alternative would be for me to build my code directly in to the 
kernel...just makes it harder for me to debug.

Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVBHPhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVBHPhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVBHPhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:37:08 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:9899 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261542AbVBHPgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:36:53 -0500
Message-ID: <4208DC74.4000107@nortel.com>
Date: Tue, 08 Feb 2005 09:36:20 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Arjan van de Ven <arjan@infradead.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: question on symbol exports
References: <41FECA18.50609@nortelnetworks.com> <1107243398.4208.47.camel@laptopd505.fenrus.org> <41FFA21C.8060203@nortelnetworks.com> <1107273017.4208.132.camel@laptopd505.fenrus.org> <20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com> <1107595148.30302.5.camel@gaston>  <42077EE0.2060505@nortel.com> <1107812101.7734.42.camel@gaston> <bc4f2e60770528d4934b5a2e69285002@embeddededge.com>
In-Reply-To: <bc4f2e60770528d4934b5a2e69285002@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Malek wrote:
> 
> On Feb 7, 2005, at 4:35 PM, Benjamin Herrenschmidt wrote:
> 
>> Interesting... more than no swap, you must also make sure you have no
>> r/w mmap'ed file (which are technically equivalent to swap).
> 
> 
> Yeah, I kinda had a similar thought.  Just because you aren't
> swapping doesn't mean the VM subsystem isn't looking at dirty bits,
> too.  It could potentially steal a page that it thinks can be replaced
> from either a zero-fill or reading again from persistent storage.

In our existing case, the app also mlock()s the pages in question.  This 
should get around these two possible sources of inaccuracy.

Chris

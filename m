Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUK0Qud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUK0Qud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUK0Qud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:50:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:49339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbUK0Qu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:50:28 -0500
Message-ID: <41A8AF8F.8060005@osdl.org>
Date: Sat, 27 Nov 2004 08:47:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Tonnerre <tonnerre@thundrix.ch>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, dwmw2@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041127042942.GA10774@pauli.thundrix.ch> <20041127035113.GK29035@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041127035113.GK29035@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Nov 27, 2004 at 05:29:42AM +0100, Tonnerre wrote:
> 
>>Fnord alert: you're trying to change the API and the ABI of Linux. The thing
> 
> 
> No we aren't.  We're just trying to make the kernel interface more
> explicit.  Nothing should change as far as userspace programs are
> concerned.  It might need some coordination with the various libcs.

Speaking of more explicit, there are various asm-ARCH header
files that do or do not hide (via __KERNEL__) interfaces
such as:	get_unaligned()
and the atomic operations.

So are these Linux kernel exported APIs, or do they belong
in some library?

We'll need to decide on a consistent remedy for these,
and such changes could be made at any time IMO (i.e., soon).


> And enough with the doom-and-gloom big-companies-are-scared approach, OK?
> It's (a) untrue, (b) irrelevant, and (c) many of us work for big companies
> that are doing Linux already.  We don't need to be lectured by you.

-- 
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbUKQD0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbUKQD0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUKQDX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:23:57 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:28274 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262185AbUKQDWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:22:20 -0500
Message-ID: <419AC3E7.9010904@yahoo.com.au>
Date: Wed, 17 Nov 2004 14:22:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       dhowells@redhat.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
References: <2315.1100630906@redhat.com>	<Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org> <20041116182841.4ff7f2e5.akpm@osdl.org> <419AC1C6.4050403@yahoo.com.au>
In-Reply-To: <419AC1C6.4050403@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> 
> Good idea. BTW, any reason why the following (very)micro optimisation
> shouldn't go in?
> 
> It currently only picks up a couple of things under fs/, but might help
> reduce other ifdefery around the place. For example mm.h: page_count and
> get_page.
> 

Like this, perhaps? It does actually introduce a change in the object
code. Namely hugetlb's put_page will now also be done inline for non
compound pages - maybe this change is unacceptable though, but it does
cut down the ifdefs.

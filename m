Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVBJJOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVBJJOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBJJOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:14:44 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19645 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262062AbVBJJOm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:14:42 -0500
References: <16906.52160.870346.806462@tut.ibm.com>
            <84144f02050209233314373462@mail.gmail.com>
            <20050210090903.GA45994@muc.de>
In-Reply-To: <20050210090903.GA45994@muc.de>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Andi Kleen <ak@muc.de>
Cc: Pekka Enberg <penberg@gmail.com>, Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com
Subject: Re: relayfs redux, part 4
Date: Thu, 10 Feb 2005 11:14:40 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.420B2600.00001EA7@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>> Please consider inlining alloc_page_array() and populate_page_array()
>> into relay_alloc_rchan_buf() as they're only used once. You'd get rid
>> of passing page_count as a pointer this way. If inlining is
>> unacceptable, please at least move the n_pages calculation to
>> relay_alloc_rchan_buf() to make the API more sane.

Andi Kleen writes:
> Modern gcc (3.3-hammer with unit-at-a-time or 3.4) will do that anyways on 
> its own.

I know that but I am commenting on readability. The pointer passing is due 
to silly interface (alloc_page_array() calculating number of pages on its 
own). 

       Pekka 

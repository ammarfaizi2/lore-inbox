Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVLMANn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVLMANn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLMANm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:13:42 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:606 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932240AbVLMANm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:13:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=idp28JmbfpCekEKYVTacgkC31/ltenmGYV7DEmlq8brRyKffChmaiWzJW+/MJi5GXvG6gXzv7ryV6OT6maQYIjKcvILxYctZXut+VBEmgyHdHwvssWxRPL2Fkau4T1rfXP44m4agYM3/mqMIY86zEQVrsJGOyksadCsV6IAxdgc=  ;
Message-ID: <439E122E.3080902@yahoo.com.au>
Date: Tue, 13 Dec 2005 11:13:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> The attached patch introduces a simple mutex implementation as an alternative
> to the usual semaphore implementation where simple mutex functionality is all
> that is required.
> 
> This is useful in two ways:
> 
>  (1) A number of archs only provide very simple atomic instructions (such as
>      XCHG on i386, TAS on M68K, SWAP on FRV) which aren't sufficient to
>      implement full semaphore support directly. Instead spinlocks must be
>      employed to implement fuller functionality.
> 

We have atomic_cmpxchg. Can you use that for a sufficient generic
implementation?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

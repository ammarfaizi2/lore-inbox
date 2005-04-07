Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVDGObp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVDGObp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVDGObp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:31:45 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:59727 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262469AbVDGObl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:31:41 -0400
Message-ID: <42554448.6080809@yahoo.com.au>
Date: Fri, 08 Apr 2005 00:31:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] freepgt2: sys_mincore ignore FIRST_USER_PGD_NR
References: <Pine.LNX.4.61.0504070210430.24723@goblin.wat.veritas.com>  <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com> <19283.1112868864@redhat.com>
In-Reply-To: <19283.1112868864@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> 
>>Remove use of FIRST_USER_PGD_NR from sys_mincore: it's inconsistent (no
>>other syscall refers to it), unnecessary (sys_mincore loops over vmas
>>further down) and incorrect (misses user addresses in ARM's first pgd).
> 
> 
> You should make it use FIRST_USER_ADDRESS instead. This check allows NULL
> pointers and suchlike to be weeded out before having to take the semaphore.
> 

I'm not sure whether it is worth keeping the singular special
case here to slightly speed up what would probably be a bug in
a userspace program.

-- 
SUSE Labs, Novell Inc.


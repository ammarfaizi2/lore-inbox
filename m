Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWCUM5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWCUM5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWCUM5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:57:11 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:18367 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751632AbWCUM5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:57:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=QrzbR+KYoOHhyAntxPrVfcGHWWLXo59RD5lXpa5Nc7bTPYbt7ebtDajVJf1/0ZjC4z8ZH8L3WLIlkiBT4QsZ5CsancJouG9iIUVNlg11UQ3AKjqJ6DI30BgdNq0DlLLueDgh6gFvR5ICwGcHeF7K6q2wYEuXVuR8dpEs9ZuHMyo=  ;
Message-ID: <441FF069.4030508@yahoo.com.au>
Date: Tue, 21 Mar 2006 23:24:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>, Stone Wang <pwstone@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced
 mlock-LRU semantic
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>	 <1142862078.3114.47.camel@laptopd505.fenrus.org> <5c49b0ed0603201552j58150a18lbf4d0a9b0406d175@mail.gmail.com>
In-Reply-To: <5c49b0ed0603201552j58150a18lbf4d0a9b0406d175@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:

> Might I suggest calling it the long_term_pinned list?  It also might
> be worth putting ramdisk pages on this list, since they cannot be
> written out in response to memory pressure.  This would eliminate the
> need for AOP_WRITEPAGE_ACTIVATE.
> 

They are for the ram filesystem, btw. and I don't think you can eliminate
AOP_WRITEPAGE_ACTIVATE, because it is needed for a number of reasons (out
of swap space being one).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

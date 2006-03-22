Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751868AbWCVAWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWCVAWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWCVAWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:22:20 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:54199 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751868AbWCVAWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ea7oE3McWaK0LBgTlNy8yYrM8XqMGXFdFzeUYY4cAgd+xIGxaeFel4Y5zYJMlVu24GmcKUo5B/GasWQqFuvtBLXFoig1znOZM6NQWeix4Oo/g6Kyg2jh1qfbutEZxB9qJhyV+aroQnXZ6XcRQ5Qs5U6Gb4FjMsbRqe6mBEqbiIU=  ;
Message-ID: <442098B6.5000607@yahoo.com.au>
Date: Wed, 22 Mar 2006 11:22:14 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>	 <441FEFC7.5030109@yahoo.com.au> <bc56f2f0603210733vc3ce132p@mail.gmail.com>
In-Reply-To: <bc56f2f0603210733vc3ce132p@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> The list potentially could have more wider use.
> 
> For example, kernel-space locked/pinned pages could be placed on the list too
> (while mlocked pages are locked/pinned by system calls from user-space).
> 

kernel-space pages are always pinned. And no, you can't put them on the list
because you never know if their ->lru field is going to be used for something
else.

Why would you want to ever do something like that though? I don't think you
should use this name "just in case", unless you have some really good
potential usage in mind.

---
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

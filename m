Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWBZKSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWBZKSt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 05:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBZKSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 05:18:49 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:26493 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751309AbWBZKSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 05:18:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lY5ogW3cbUY9seLxHdqmv0eJroibcQJN56eQKxzWA9gjDSrceX9Bp3RKkUrQoG3uJplt6QEdczW+R7Wa+0xk58VUXnxOWxE7ZGLDsxl0NZIgCXGJSX748pe7SSnG7DKtAsTxKAPDMskJ/7r/ndv8ZUYHe7Ql5kj9MGPDXgG0gcc=  ;
Message-ID: <4401807C.60106@yahoo.com.au>
Date: Sun, 26 Feb 2006 21:18:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
References: <20060226100518.GA31256@flint.arm.linux.org.uk> <20060226021414.6a3db942.akpm@osdl.org>
In-Reply-To: <20060226021414.6a3db942.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
>>Calling serial functions to flush buffers, or try to send more data
>> after the port has been closed or hung up is a bug in the code doing
>> the calling, not in the serial_core driver.
>>
>> Make this explicitly obvious by adding BUG_ON()'s.
> 
> 
> If we make it
> 
> 	if (!info) {
> 		WARN_ON(1);
> 		return;
> 	}
> 
> will that allow people's kernels to limp along until it gets fixed?

Any reason we don't have a WARN(), btw?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVKBCJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVKBCJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVKBCJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:09:26 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:7311 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932201AbVKBCJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:09:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TFsGaqU3w1k+HMqvHYHssguwilA0v507vugJSNK0aToz6XRehCy+AVm+eglkZrUTHIVD0akuCSL1JtjYJCLLPXmm8eZ0qqqgmI13PUQZu0lo+pC73zxYeGCc5C4M3SMDeyQ+81fw2SBL5ycie30QnwrAPnEXSY+bBVzVdpwRhyU=  ;
Message-ID: <43681FDC.4060202@yahoo.com.au>
Date: Wed, 02 Nov 2005 13:09:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> <4368139A.30701@vc.cvut.cz>
In-Reply-To: <4368139A.30701@vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> 
> But get_user_pages() was not invoked by 'the core vm'.  I invoked it, 
> from my
> module...  same one which populated this VMA before.
> 

OK, sure in this case it should be fine because you know what you're
doing. In the case where someone submits a /dev/mem mapping for direct
IO, things would be different.


> So I've made this change...  Test probably could be for 2.6.4 <= x <= 
> 2.6.5 to rule out all buggy kernels, but I'll probably leave it this way 
> unless there is some good reason to not set VM_RESERVED on these older 
> kernels.
> 

OK, if that is all that is required to fix it for you, then that's
a good result! Thanks for the mail and be sure to let us know if you
run into any other problems.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

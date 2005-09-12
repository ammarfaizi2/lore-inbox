Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVILO0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVILO0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVILO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:26:49 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:34913 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751020AbVILO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:26:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=zEUy1yV7qSaQc8gJU+VZD5kQQex1asZ+9eiqMokLcBEekHRFsrD+JXRTpKduyJnZXBALzV337TsjqM+lyAy2P6n4e7vj35Wk6JPkxMV23uLo58r2wWR9v9w4gwRQnJ8rO1azofpRNphP1qlLLyX5QV0H29gXgnyvAi+WCmVmYFQ=  ;
Message-ID: <43259022.3030603@yahoo.com.au>
Date: Tue, 13 Sep 2005 00:26:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm3
References: <20050912024350.60e89eb1.akpm@osdl.org> <200509121517.31562.andrew@walrond.org>
In-Reply-To: <200509121517.31562.andrew@walrond.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:
> On Monday 12 September 2005 10:43, Andrew Morton wrote:
> 
> 
>>  - An update to the anticipatory scheduler to fix a performance problem
>>    where processes do a single read then exit, in the presence of
>>competing I/O acticity.
> 
> 
> Is there more discussion on this somewhere? When was the problem introduced? 
> Bit of a long shot, but it fits the description of some problems I have 
> noticed recently.
> 

It has been quite a while coming. The problem has been there for a long
time, but there is no "regression" that would not exist in eg. deadline
scheduler.

Basically it used to "miss" opportunities to do read anticipation where it
should pay off, and now it misses less.

A description of / pointer to your problems would be interesting.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 

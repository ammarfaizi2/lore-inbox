Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWHHQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWHHQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWHHQ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:26:49 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:53872 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964978AbWHHQ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:26:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=R75mbztHhBTSr8c4xTHKtCYs7NoS/nESMKmQug0Vtd2pw37uCOU66pUxNA5EGCwR8xmpftt59bU63Vm0/NatFBCp/fXq9c6VOdwMAPF0pfPOkL7ET3tI9pPE4Mbqvy/5D3eJKfttARoFAVqwJbf4W3FkTfKr86XxR1pdDNWsOmc=  ;
Message-ID: <44D8BB43.9070908@yahoo.com.au>
Date: Wed, 09 Aug 2006 02:26:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>	 <200608081429.44497.dada1@cosmosbay.com>	 <200608081447.42587.ak@suse.de>	 <200608081457.11430.dada1@cosmosbay.com>	 <a36005b50608080739w2ea03ea8i8ef2f81c7bd55b5d@mail.gmail.com>	 <44D8A9BE.3050607@yahoo.com.au> <a36005b50608080836u3e58ab85l61bb50b2bac5a0e3@mail.gmail.com> <44D8BA39.5020405@yahoo.com.au>
In-Reply-To: <44D8BA39.5020405@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> No we shouldn't slow them down. I'd be interested to see whether
> locking is significantly sped up with this new data structure,
> though.

OTOH, maybe you don't need a new data structure. Maybe you could
use the hash and check that for a match on a private futex before
trying to find a possible shared futex.

Locking I guess becomes no more of a problem than now, and in some
cases maybe much less. So OK, I stand corrected.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

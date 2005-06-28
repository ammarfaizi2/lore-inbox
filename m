Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVF1Xnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVF1Xnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVF1XnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:43:23 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:56684 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262281AbVF1XLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:11:08 -0400
Message-ID: <42C1D8F4.2010601@yahoo.com.au>
Date: Wed, 29 Jun 2005 09:10:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Anton Blanchard <anton@samba.org>
Subject: Re: [patch 2] mm: speculative get_page
References: <42C0AAF8.5090700@yahoo.com.au> <20050628040608.GQ3334@holomorphy.com> <42C0D717.2080100@yahoo.com.au> <20050627.220827.21920197.davem@davemloft.net> <20050628141903.GR3334@holomorphy.com> <42C17028.6050903@yahoo.com.au> <Pine.LNX.4.62.0506280959100.10511@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0506280959100.10511@graphe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 29 Jun 2005, Nick Piggin wrote:
> 
> 
>>But nit picking aside, is it true that we need a load barrier before
>>unlock? (store barrier I agree with) The ppc64 changeset in question
>>indicates yes, but I can't quite work out why. There are noises in the
>>archives about this, but I didn't pinpoint a conclusion...
> 
> 
> A spinlock may be used to read a consistent set of variables. If load
> operations would be moved below the spin_unlock then one may get values
> that have been updated after another process acquired the spinlock.
> 
> 

Of course, thanks. I was only thinking of the case where loads
were moved from the unlocked into the locked section.

Send instant messages to your online friends http://au.messenger.yahoo.com 

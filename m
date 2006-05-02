Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWECAxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWECAxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWECAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:53:48 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:38822 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965061AbWECAxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:53:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=N/MB58IHVXndKEBD+rOB/kWjqBBQR4LJ8VgGgiwAYlpIVnq7Mxl3+HeylDkSfg00aDZOTcLZ911i7dbnbQyC1tzw8tVV/Dyc7xIJy3B0h2OLoRp178vVP0lxCAohWiq/v3xQ+RYWlEyFh9nE7q6e70ypxn7KS7ohn0BTUj07fc8=  ;
Message-ID: <445791D3.9060306@yahoo.com.au>
Date: Wed, 03 May 2006 03:07:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de>
In-Reply-To: <200605021859.18948.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 02 May 2006 18:54, Christopher Friesen wrote:
> 
>>Andi Kleen wrote:
>>
>>
>>>Agreed it's a problem, but probably a small one. At worst you'll get
>>>a small scheduling hickup every half year, which should be hardly 
>>>that big an issue.
>>
>>Presumably this would be bad for soft-realtime embedded things.  Set-top 
>>boxes, etc.
> 
> 
> SCHED_RR/FIFO are not affected. AFAIK it's only used by the interactivity
> detector in the normal scheduler. Worst case that happens is that a 
> process is not detected to be interactive when it should once, which
> gives it only a small penalty. On the next time slice everything will be ok again.

Other problem is that some people didn't RTFM and have started trying to
use it for precise accounting :(

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265191AbUD3N7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUD3N7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUD3N7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:59:34 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:57714 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265191AbUD3N7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:59:32 -0400
Message-ID: <40924F83.2080100@yahoo.com.au>
Date: Fri, 30 Apr 2004 23:07:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <Pine.LNX.4.44.0404300849480.6976-200000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404300849480.6976-200000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 30 Apr 2004, Nick Piggin wrote:
> 
>> Rik van Riel wrote:
> 
> 
>> > The basic idea of use-once isn't bad (search for LIRS and
>> > ARC page replacement), however the Linux implementation
>> > doesn't have any of the checks and balances that the
>> > researched replacement algorithms have...
> 
> 
>> No, use once logic is good in theory I think. Unfortunately
>> our implementation is quite fragile IMO (although it seems
>> to have been "good enough").
> 
> 
> Hey, that's what I said ;))))
> 

Yes. I just thought you might have misunderstood me to
think use once is no good at all.

>> This is what I'm currently doing (on top of a couple of other
>> patches, but you get the idea). I should be able to transform
>> it into a proper use-once logic if I pick up Nikita's inactive
>> list second chance bit.
> 
> 
> Ummm nope, there just isn't enough info to keep things
> as balanced as ARC/LIRS/CAR(T) can do.  No good way to
> auto-tune the sizes of the active and inactive lists.
> 

I think perhaps it might be possible. I don't want to
discourage you from looking into more interesting replacement
schemes though. I don't doubt that our basic replacement
can often be suboptimal ;)

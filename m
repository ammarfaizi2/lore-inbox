Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWIFTTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWIFTTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWIFTTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:19:40 -0400
Received: from relay01.pair.com ([209.68.5.15]:35336 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751505AbWIFTTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:19:39 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 6 Sep 2006 14:15:46 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: ellis@spinics.net
cc: w@1wt.eu (Willy Tarreau), ellis@spinics.net (Rick Ellis),
       linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
In-Reply-To: <200609061856.k86IuS61017253@no.spam>
Message-ID: <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse>
References: <200609061856.k86IuS61017253@no.spam>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, ellis@spinics.net wrote:

>> OK, but doing something could simply consist in adding a header
>> that anyone is free to filter on or not.
>
> The problem with that is the post gets no indication that his
> mail has been filtered. The way it works now is the rejection
> happens at SMTP time and that causes the poster to see the
> problem. If people filtered on a header, you'd never know why you
> weren't getting a response.
>

How about this:

1. Incoming mail from subscribers is accepted
2. Incoming mail to honeypot addresses is trained as SPAM
3. Incoming mail from non-subscribers is marked with X-Bogofilter:
4. A handy Perl script subscribes to lkml, and for any message it gets 
with an X-Bogofilter: SPAM header, it sends a notification (rate-limited) 
to the message sender explaining that his message will be filtered as SPAM 
by some recipients, and inviting him to contact postmaster to resolve the 
issue, and additionally letting him know that notification is rate-limited 
and there is a website he can check to see the SUBJECTs of all messages 
filtered as SPAM on lkml (say for the last week or two) if he wants to try 
and correct the problem himself.

Thanks,
Chase

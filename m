Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272838AbTHKREX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272837AbTHKRBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:01:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8939 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272838AbTHKQ7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:59:08 -0400
Message-ID: <3F37CB44.5000307@pobox.com>
Date: Mon, 11 Aug 2003 12:58:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com>
In-Reply-To: <20030811164012.GB858@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> A few comments on why I don't like this patch:
>     1) It's a formatting only patch.  That screws over people who are using
>        BK for debugging, now when I double click on these changes I'll get
>        to your cleanup patch, not the patch that was the last substantive
>        change.

This is true, but at the same time, in Linux CodingStyle patches 
culturally acceptable.  I think the general logic is just "don't go 
overboard; reformat a tiny fragment at a time."


>     2) "if (expr) statement;" really ought to be considered legit coding style.
>        It's a one line "shorty" and it lets you see more of the code on a 
>        screen.
>     
> On the other hand, the author carried things too far when they did
> 
> 	if (expr) statement;
> 	else	  statement;
> 
> that's too hard for your eyes to parse quickly IMO.


tee hee :)  This is why we have Documentation/CodingStyle, for just this 
type of discussion.

I actually prefer your "author carried ... too far" example, with the 
reasoning:  if you _must_ deviate from CodingStyle, at least don't run 
the damn lines together like
	if (test) foo else bar;
		or
	if (test) foo
	else bar;

The alignment of the statements visually separates out the test more 
clearly.

	Jeff



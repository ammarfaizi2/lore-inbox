Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWDBOJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWDBOJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWDBOJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:09:24 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:12222 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932343AbWDBOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:09:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TASoCLnXyYbZ0VmOwA0Aekdz8pEbZTRvU/wQXoXTVEaQiX1E75tJgmRFFRf6L6yldxL5XCjYu2ubWtLzi7Er1JoYAN4PNnc4ffApH1btAaABwkV/B1keIVsnOADS/q5k66d0kF1dAp+/85dDXYhmGTqiBfq4ajqfb8gCLNvSh+g=  ;
Message-ID: <442F9B55.9030809@yahoo.com.au>
Date: Sun, 02 Apr 2006 19:37:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-ck3
References: <200604021401.13331.kernel@kolivas.org> <442F5721.2040906@yahoo.com.au> <200604021851.39763.kernel@kolivas.org>
In-Reply-To: <200604021851.39763.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Sunday 02 April 2006 14:46, Nick Piggin wrote:
> 
> Curious. I was under the impression lowmem reserve only did anything if you 
> manually set it, and the users reporting on swap prefetch behaviour are not 
> the sort of users likely to do so. I'm happy to fix whatever the lowmem 

It is enabled by default for over a year.

> reserve bug is but I doubt this bug is making swap prefetch behave better for 
> ordinary users. Well, whatever the case is I'll have another look at lowmem 
> reserve of course. 
> 

It would potentially make swap prefetch very happy to swap pages into the
dma zone and the normal zone on highmem systems when the system is
otherwise full of pagecache. So it might easily change behaviour on those
systems.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

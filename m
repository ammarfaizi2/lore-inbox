Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWDZUpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWDZUpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWDZUpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:45:24 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:8327 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932141AbWDZUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:45:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HJX1KdpqY6HKmgNXMipMJqtrgZwFS883rf7zD9B+mziLyGfczr5/Frd4BMYCWALDOE1y7OEEhd5hasgxvUXiVEqIrhfEANwJuLdNCGM/rK/SqHfFrk+Vp6NiNdVR1X7CVXABAw1eqLMGpS8LQgC+ZhL6evcq3UBlMbARPPRwsuY=  ;
Message-ID: <444F9E2D.2000901@yahoo.com.au>
Date: Thu, 27 Apr 2006 02:22:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nigel Cunningham <nigel@suspend2.net>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl> <444ED9EB.5060205@yahoo.com.au> <200604261341.32500.nigel@suspend2.net>
In-Reply-To: <200604261341.32500.nigel@suspend2.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,
thanks

Nigel Cunningham wrote:
> Hi Nick.
> 
> On Wednesday 26 April 2006 12:24, Nick Piggin wrote:
> 
>>Rafael J. Wysocki wrote:
>>
>>>This means if we freeze bdevs, we'll be able to save all of the LRU pages,
>>>except for the pages mapped by the current task, without copying.  I think
>>>we can try to do this, but we'll need a patch to freeze bdevs for this
>>>purpose. ;-)
>>
>>Why not the current task? Does it exit the kernel? Or go through some
>>get_uesr_pages path?
> 
> 
> I think Rafael is asleep at the mo, so I'll answer for him - he's wanting it 
> to be compatible with using userspace to control what happens (uswsusp). In 
> that case, current will be the userspace program that's calling the ioctls to 
> get processes frozen etc.

OK, so what happens if, upon exit from kernel, that userspace task
subsequently changes some pagecache but doesn't have that mapped? Or
mmaps something then changes it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

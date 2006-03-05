Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWCENaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWCENaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 08:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWCENaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 08:30:19 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:27839 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750953AbWCENaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 08:30:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ahsl6PkrBv1aOclDcN5rxGC11sUoRAfbjeFDbKaSjDUz1r81hP0FStHsl2FfrAorDgaYzbECxGG/l0LeobIy4WefcwCm/0lGTHQAaZJhwFZMYVbYr3eXeMtmbPFjAh5jkvTYqmJWM7mhNdvktj+9C0zJUPeNPH09Ai74Z9JqtxU=  ;
Message-ID: <440AE7E3.4060500@yahoo.com.au>
Date: Mon, 06 Mar 2006 00:30:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Ra=FAl_Baena?= <raul_baena@ya.com>
CC: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
References: <4407584A.60301@ya.com> <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com> <440AE3F3.3090404@ya.com>
In-Reply-To: <440AE3F3.3090404@ya.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raúl Baena wrote:
> Thank you very much Jon. But I think I haven´t explained very well.
> 
> I know that now the prio_array and runqueues structs aren´t accesible 
> for modules, but in the 2.6.5 version they were. I would like to know 
> the reason, why before they were accesible and now they don´t? If you 
> could answer me, it would be great.

I don't remember them being available in 2.6.5... but as to why they
aren't available now: it is much cleaner this way. It even benefits
you because now nobody will break your module when they change the
data structure.

> I could to write the reason in my 
> university job. (In Spain we have to make a final degree job, and mine 
> is about modules in linux (I chose this), I would like to show 
> information of the new scheduler, a scheduler monitor, and these fields 
> are indispensable for me)

If your task is about modules in Linux, then I don't see how that
involves the scheduler at all?

On the other hand, if you want a scheduler monitor then I can't see
why it would be appropriate to implement as a module (we have schedstats,
which you can read from a userspace program or daemon).

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

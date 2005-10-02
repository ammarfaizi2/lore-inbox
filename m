Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVJBKgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJBKgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 06:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVJBKgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 06:36:24 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:2440 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751070AbVJBKgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 06:36:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lX1/qJqpzcqoiatn398Z8Fd/ML4kRy30tDQezu3NXZMZkDYOi36lQeIZgZsz+kJI0hcj980Vs1VOk4tvJ/lONoc3IfwxUJEOOidkS32Y1Vx5eJ1XahnosXVeNpjPw63SJC8dIg1u8wXk18QF7pv/bnnWY2A9NsfAmd0OZsUv6s4=  ;
Message-ID: <433FB863.5070009@yahoo.com.au>
Date: Sun, 02 Oct 2005 20:37:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> <433FAD57.7090106@yahoo.com.au> <433FBE59.8000806@superbug.co.uk>
In-Reply-To: <433FBE59.8000806@superbug.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> I have a requirement to pass information from the kernel to user space. 
> The information is passed fairly rarely, but over time extra parameters 
> are added. At the moment we just use a struct, but that means that the 
> kernel and the userspace app have to both keep in step. If something 
> like XML was used, we could implement new parameters in the kernel, and 
> the user space could just ignore them, until the user space is upgraded.
> XML would initially seem a good idea for this, but are there any methods 
> currently used in the kernel that could handle these parameter changes 
> over time.
> 
> For example, should the sysfs be used for this?
> 
> Any comments?
> 

Yes use sysfs (or procfs if the information is related to a process).
Using ASCII text representation, and a single value per file is
noramlly the preferred method to do this I think.

Nick

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 

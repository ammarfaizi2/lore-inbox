Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266206AbUFYExh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUFYExh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 00:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbUFYExh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 00:53:37 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:16115 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266199AbUFYExf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 00:53:35 -0400
Message-ID: <40DBAFB0.5000109@nortelnetworks.com>
Date: Fri, 25 Jun 2004 00:53:04 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: sys_gettimeofday racy or not?
References: <20040625002057.GA3052@wiggy.net>
In-Reply-To: <20040625002057.GA3052@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> This just happened to catch my eye and it's probably perfectly
> valid, but if so please educate me on why it is. In kernel/time.c
> sys_gettimeofday() there is this code:
> 
>         if (unlikely(tz != NULL)) {
>                 if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
>                         return -EFAULT;
>         }
> 
> what prevents sys_tz from being changed while this code runs?

Nothing at all.

I suspect most people don't worry about it, since its use is deprecated.  The 
man page for gettimeofday() says "The use of the timezone struct is obsolete".

Chris

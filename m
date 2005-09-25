Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVIYUzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVIYUzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVIYUzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 16:55:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:43932 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932288AbVIYUzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 16:55:08 -0400
Date: Sun, 25 Sep 2005 13:55:18 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] fixes for overflow in poll(), epoll(), and msec_to_jiffies()
Message-ID: <20050925205518.GB5079@us.ibm.com>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924193839.GB26197@alpha.home.local>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.2005 [21:38:39 +0200], Willy Tarreau wrote:
> Hello,
> 
> After the discussion around epoll() timeout, I noticed that the functions used
> to detect the timeout could themselves overflow for some values of HZ.
> 
> So I decided to fix them by defining a macro which represents the maximal
> acceptable argument which is guaranteed not to overflow. As an added bonus,
> those functions can now be used in poll() and ep_poll() and remove the divide
> if HZ == 1000, or replace it with a shift if (1000 % HZ) or (HZ % 1000) is a
> power of two.
> 
> Patches against 2.6.14-rc2-mm1 sent as replies to this mail.

These look really good, Willy. Thanks for the fixes!

-Nish

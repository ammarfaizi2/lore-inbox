Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVEKBS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVEKBS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVEKBS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:18:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24308 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261869AbVEKBS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:18:58 -0400
Message-ID: <42812D54.2070500@mvista.com>
Date: Tue, 10 May 2005 14:53:24 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Eisenbach <int2str@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High res timer?
References: <7f800d9f050510132762f0ee7@mail.gmail.com>
In-Reply-To: <7f800d9f050510132762f0ee7@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Eisenbach wrote:
> Hello!
> 
> We're currently using pth_usleep() as a timer for a userspace audio
> application. However, it doesn't seem very accurate and reliable. Is
> there a better (more accurate) timer that we can call form a userspace
> application?

You don't say what resolution you want, but to ~ 1 ms, nanosleep or 
clock_nanosleep should work.  If you need better resolution, check out the HRT 
patch, see sig. below.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

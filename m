Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSKBVbd>; Sat, 2 Nov 2002 16:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbSKBVbd>; Sat, 2 Nov 2002 16:31:33 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:61898 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261434AbSKBVb3>;
	Sat, 2 Nov 2002 16:31:29 -0500
Date: Sat, 2 Nov 2002 22:37:59 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll r2 ...
Message-ID: <20021102213759.GA9440@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211021126110.951-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021126110.951-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:40:55AM -0800, Davide Libenzi wrote:

> http://www.xmailserver.org/linux-patches/epoll.txt

This page still contains:

       Furthermore, the function do_use_fd() immediately tries to read(2)
       from the fd. If it does not do so, there is a race condition with the
       risk of losing an event before interest in it was registered.  This
       read may well return EAGAIN, which should be a cause for calling
       epoll_wait().

Am I correct in understanding that this is no longer true because epoll_ctl
inserts an event if the poll condition is met?

Furthermore, I don't think the epoll(2) page is that helpful as even an
application developer that follows lkml (ie, me) has any use of the
'waitqueue' analogy.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

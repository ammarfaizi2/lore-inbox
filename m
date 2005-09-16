Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVIPX7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVIPX7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVIPX7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:59:09 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:15884 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750812AbVIPX7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:59:07 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Fix epoll delayed initialization bug ...
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 16 Sep 2005 16:59:02 -0700
In-Reply-To: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain> (Davide
 Libenzi's message of "Fri, 16 Sep 2005 16:35:34 -0700 (PDT)")
Message-ID: <52hdckk1ix.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 16 Sep 2005 23:59:03.0030 (UTC) FILETIME=[9D2AD160:01C5BB1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Davide> Al found a potential problem in epoll_create(), where the
    Davide> file->private_data member was set after fd_install(). This is
    Davide> obviously wrong since another thread might do a close() on
    Davide> that fd# before we set the file->private_data member. This
    Davide> goes over 2.6.13 and passes a few basic tests I've done here.

Actually, I found the problem after Al pointed out a similar bug in my code ;)

 - R.

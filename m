Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVIQFrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVIQFrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVIQFrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 01:47:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23972 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750939AbVIQFrp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 01:47:45 -0400
Date: Sat, 17 Sep 2005 06:47:42 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roland Dreier <rolandd@cisco.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Fix epoll delayed initialization bug ...
Message-ID: <20050917054742.GI19626@ftp.linux.org.uk>
References: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain> <52hdckk1ix.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52hdckk1ix.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 04:59:02PM -0700, Roland Dreier wrote:
>     Davide> Al found a potential problem in epoll_create(), where the
>     Davide> file->private_data member was set after fd_install(). This is
>     Davide> obviously wrong since another thread might do a close() on
>     Davide> that fd# before we set the file->private_data member. This
>     Davide> goes over 2.6.13 and passes a few basic tests I've done here.
> 
> Actually, I found the problem after Al pointed out a similar bug in my code ;)

Yup.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTEPJvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 05:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTEPJvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 05:51:42 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:46788 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264398AbTEPJvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 05:51:41 -0400
Date: Fri, 16 May 2003 12:04:32 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@digeo.com>, ch@murgatroid.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516100432.GA21627@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@digeo.com>, ch@murgatroid.com,
	linux-kernel@vger.kernel.org
References: <20030516015407.2768b570.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516015407.2768b570.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 01:54:07AM -0700, Andrew Morton wrote:

> +CONFIG_EPOLL.patch
> 
>  Make epoll disableable.

Please don't! For the same reason as the futexes, turning this off will
randombly break stuff and on a pc it won't give any benefit.

I'd vote for treating this patch just like the futexes one, making sure that
those who know *how* can turn epoll off, but leave it out of make config.

Furthermore, I wonder if this patch is a large savings, the bulk of epoll is
infrastructure, not the few syscalls.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267217AbUBSOvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUBSOvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:51:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59652 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267217AbUBSOve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:51:34 -0500
Date: Thu, 19 Feb 2004 14:51:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org, Michal Wronski <wrona@mat.uni.torun.pl>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC][PATCH] 1/6 POSIX message queues
Message-ID: <20040219145120.A23685@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org,
	Michal Wronski <wrona@mat.uni.torun.pl>,
	Manfred Spraul <manfred@colorfullife.com>
References: <Pine.GSO.4.58.0402191525500.18841@Juliusz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0402191525500.18841@Juliusz>; from golbi@mat.uni.torun.pl on Thu, Feb 19, 2004 at 03:26:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think instead of a single util.c you want an util.c shared by both
and an sysvutil.c only for the sysv ipc stuff.  Together with changing the
sysv ipc stubs to cond_syscall that should get rid of all those horrible
ifdefs.


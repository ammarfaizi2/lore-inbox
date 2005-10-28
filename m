Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbVJ1JWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVJ1JWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbVJ1JWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:22:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31933 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965202AbVJ1JV7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:21:59 -0400
Date: Fri, 28 Oct 2005 10:21:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
Subject: Re: [PATCH] kobject: fix gfp flags type
Message-ID: <20051028092155.GW7992@ftp.linux.org.uk>
References: <11304810221164@kroah.com> <11304810221338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11304810221338@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:30:22PM -0700, Greg KH wrote:
> [PATCH] kobject: fix gfp flags type
> 
> Fix implicit nocast warnings in kobject_uevent code, including __nocast:
> lib/kobject_uevent.c:78:37: warning: implicit cast to nocast type
> lib/kobject_uevent.c:97:51: warning: implicit cast to nocast type
> lib/kobject_uevent.c:120:27: warning: implicit cast to nocast type
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

NAK - explicit use of __nocast is wrong here.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266846AbSL3KsT>; Mon, 30 Dec 2002 05:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSL3KsT>; Mon, 30 Dec 2002 05:48:19 -0500
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:64516 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266846AbSL3KsS>; Mon, 30 Dec 2002 05:48:18 -0500
Date: Mon, 30 Dec 2002 10:57:15 +0000
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] [PATCH] add kobject to struct mapped_device
Message-ID: <20021230105715.GC2703@reti>
References: <20021218184307.GA32190@kroah.com> <20021219105530.GA2003@reti> <20021220083149.GA10484@kroah.com> <20021220094447.GA1169@reti> <20021220174952.GB12128@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220174952.GB12128@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 09:49:52AM -0800, Greg KH wrote:
> I saw that logic.  I don't think sysfs can handle poll right now, but we
> could modify the last access/modify/change time when the status changes
> so stat(2) can be used on the file.  This is how usbfs currently
> notifies userspace of changes to their files.  Would this be acceptable?

Blech.  The nice thing about a blocking operation like poll is that
the process doesn't keep getting rescheduled to check if there is
anything to do.

- Joe

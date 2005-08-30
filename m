Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbVH3O4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVH3O4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVH3O4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:56:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1861
	"EHLO g5.random") by vger.kernel.org with ESMTP id S932170AbVH3O4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:56:12 -0400
Date: Tue, 30 Aug 2005 16:56:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
Message-ID: <20050830145602.GN8515@g5.random>
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:01:21AM +0200, Sven Ladegast wrote:
> [..] combined 
> with an automatic oops/panic/bug-report this would be _very_ useful I think.

That would be nice addition IMHO. It'll be more complex since it'll
involve netconsole dumping and passing the klive session to the kernel
somehow (userland would be too unreliable to push the oops to the
server). The worst part is that oops dumping might expose random kernel
data (it could contain ssh keys as well), so I would either need to
purify the stack/code/register lines making the oops quite useless, or
not to show it at all (and only to show the count of the oopses
publically). A parameter could be used to tell the kernel if the whole
oops should be sent to the klive server or if only the notification an
oops should be sent (without sending the payload with potentially
sensitive data inside).

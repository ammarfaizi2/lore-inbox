Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUJRVYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUJRVYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUJRVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:24:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:42905 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267343AbUJRVVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:21:25 -0400
Date: Mon, 18 Oct 2004 14:25:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
Message-Id: <20041018142524.5b81a09a.akpm@osdl.org>
In-Reply-To: <1098117067.2011.64.camel@mulgrave>
References: <1098117067.2011.64.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> I'm in the process of moving some of our scsi timers which do more work
> than just a few lines of code into schedule_work() instead.  The problem
> is that the workqueue API lacks the equivalent of del_timer_sync(). 

The usual way of doing this is:

	cancel_delayed_work(...);
	flush_workqueue(...);



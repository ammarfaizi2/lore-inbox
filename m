Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265018AbTFLVxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbTFLVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:53:49 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:44738 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265018AbTFLVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:53:47 -0400
Date: Thu, 12 Jun 2003 15:03:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-Id: <20030612150335.6710a94f.akpm@digeo.com>
In-Reply-To: <20030612214753.GA1087@kroah.com>
References: <3EE8D038.7090600@mvista.com>
	<20030612214753.GA1087@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 22:07:32.0810 (UTC) FILETIME=[05DD02A0:01C3312F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > 3) /sbin/hotplug events can occur out of order, eg: remove event occurs, 
> > /sbin/hotplug sleeps waiting for something, insert event occurs and 
> > completes immediately.  Then the remove event completes, after the 
> > insert, resulting in out-of-order completion and a broken /dev.  I have 
> > seen this several times with udev.
> 
> I responded:
> 	Yes this happens.  I have a fix for this for udev itself.  No
> 	kernel changes are needed.  I'll show it at OLS in July if you
> 	want to see it :)

This is a significantly crappy aspect of the /sbin/hotplug callout.  I'd be
very interested in reading an outline of how you propose fixing it, without
waiting until OLS, thanks.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTDKV5y (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbTDKV5y (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:57:54 -0400
Received: from [12.47.58.73] ([12.47.58.73]:56557 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261807AbTDKV5x (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:57:53 -0400
Date: Fri, 11 Apr 2003 15:09:33 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Dake <sdake@mvista.com>
Cc: kpfleming@cox.net, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, message-bus-list@redhat.com,
       greg@kroah.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-Id: <20030411150933.43fd9a84.akpm@digeo.com>
In-Reply-To: <3E9725C5.3090503@mvista.com>
References: <20030411172011.GA1821@kroah.com>
	<200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>
	<20030411182313.GG25862@wind.cocodriloo.com>
	<3E970A00.2050204@cox.net>
	<3E9725C5.3090503@mvista.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 22:09:30.0837 (UTC) FILETIME=[069A0050:01C30077]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Dake <sdake@mvista.com> wrote:
>
> A much better solution could be had by select()ing on a filehandle 
> indicating when a new hotswap event is ready to be processed.  No races, 
> no security issues, no performance issues.

I must say that I've always felt this to be a better approach than the
/sbin/hotplug callout.

Apart from the performance issue, it means that the kernel can buffer the
"insertion" events which happen at boot-time discovery until the userspace
handler attaches itself.


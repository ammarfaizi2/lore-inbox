Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbWASI4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbWASI4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 03:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWASI4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 03:56:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161281AbWASI4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 03:56:17 -0500
Date: Thu, 19 Jan 2006 00:56:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Andy Chittenden" <AChittenden@bluearc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-Id: <20060119005600.4e465e9d.akpm@osdl.org>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C2703555F85@uk-email.terastack.bluearc.com>
References: <89E85E0168AD994693B574C80EDB9C2703555F85@uk-email.terastack.bluearc.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andy Chittenden" <AChittenden@bluearc.com> wrote:
>
> Why does running the following command cause processes to be killed:
> 
> 	dd if=/dev/zero of=/u/u1/andyc/tmpfile bs=1M count=8k
> 
> And I noticed one of my windows disappeared. Further investigation
> showed that was my terminator window (java based app: see
> http://software.jessies.org/terminator/). I found this in my syslog:
> 
> Jan 17 11:12:58 boco kernel: Out of Memory: Killed process 16498 (java).
> 
> My hardware: amd64 based machine (ASUS A8V Deluxe motherboard) with 4Gb
> of memory.
> My kernel: debian package linux-image-2.6.15-1-amd64-k8 package
> installed. IE its running 2.6.15 compiled for amd64.
> 
> This is repeatable. The above dd command also causes the machine to
> become very unresponsive (eg windows don't focus).

What type of filesytem is being written to?

Has someone tuned /proc/sys/vm/swappiness, or something else under
/proc/sys/vm?

It'd be useful to see the dmesg output from that oom event.

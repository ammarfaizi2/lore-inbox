Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWDSXad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWDSXad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 19:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDSXad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 19:30:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751236AbWDSXac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 19:30:32 -0400
Date: Wed, 19 Apr 2006 16:32:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ken Witherow <ken@krwtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advansys SCSI driver and 2.6.16
Message-Id: <20060419163247.6986a87c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604191444200.1841@death>
References: <Pine.LNX.4.64.0604191444200.1841@death>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Witherow <ken@krwtech.com> wrote:
>
> I use an Advansys controller for an old, slow SCSI drive and my flatbed 
> scanner. I noticed that upon trying to boot 2.6.16, my Advansys controller 
> wasn't detected. Further investigation shows that the driver has been 
> fairly silently disappearing over the last couple releases.
> 
> Is this a permanent change or is the Advansys driver just in need of some 
> updating to current APIs? I'd hate to have to replace this controller and 
> I don't want to be stuck at 2.6.15 forever. If someone could point me in 
> the right direction about what the problem is, I'd be glad to take a look 
> at seeing if I could fix it.

There have been no changes in the advansys driver since November 2005, and
nothing substantial in over a year.  So I'd say what we have here is either
a faulty .config or a bug.

Please check the .config and if it looks OK, provide a full description of
the problem.  It may be useful to do

boot (2.6.15)
dmesg -s 1000000 > 1
boot (2.6.16)
dmesg -s 1000000 > 2
diff -u 1 2 > 3

and include `3' in the report.

Thanks.

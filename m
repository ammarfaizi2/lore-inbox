Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUDBKZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUDBKZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:25:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:29582 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263587AbUDBKZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:25:08 -0500
Date: Fri, 2 Apr 2004 02:23:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
Message-Id: <20040402022348.00d55268.akpm@osdl.org>
In-Reply-To: <406D21F6.8080005@A88c0.a.pppool.de>
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
	<20040328200710.66a4ae1a.akpm@osdl.org>
	<4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>
	<1080570227.20685.93.camel@watt.suse.com>
	<406D21F6.8080005@A88c0.a.pppool.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@freenet.de> wrote:
>
> Now, I tested 2.6.5-rc3-mm4. Same procedure.
>  The good news first:
>  2.6.5-rc3-mm4 is nearly as fast as 2.4.25 - it is about 2% slower than 
>  2.4.25 (with preemption turned on).
> 
>  Now the bad news:
>  The system-processor-time is unchanged abnormal high: it is 34% (!) higher 
>  than in 2.4.25 (and about 1% more than in 2.4.6).
> 
> 
>  Btw: Did the other profile outputs help to find the problem?
> 
>  These are the profile-values for an example run (make of kernel 2.6.5rc2) 
>  with 2.6.5rc3mm4:

Spending a lot of time on do_softirq() while compiling stuff is peculiar.

What device drivers are running at the time?  disk/network/usb/etc?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVGPVle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVGPVle (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVGPVld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 17:41:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261411AbVGPVks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 17:40:48 -0400
Date: Sat, 16 Jul 2005 14:39:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1: a regression
Message-Id: <20050716143945.735906ce.akpm@osdl.org>
In-Reply-To: <200507162330.18810.rjw@sisk.pl>
References: <20050715013653.36006990.akpm@osdl.org>
	<200507162330.18810.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Friday, 15 of July 2005 10:36, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
>  > 
>  > (http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-rc3-mm1.gz until
>  > kernel.org syncs up)
> 
>  There seems to be a regression wrt 2.6.13-rc3 which causes my box (Asus L5D,
>  Athlon 64 + nForce3) to hang solid during resume from disk on battery power.
> 
>  First, 2.6.13-rc3-mm1 is affected by the problems described at:
>  http://bugzilla.kernel.org/show_bug.cgi?id=4416
>  http://bugzilla.kernel.org/show_bug.cgi?id=4665
>  These problems go away after applying the two attached patches.  Then, the
>  box resumes on AC power but hangs solid during resume on battery power.
>  The problem is 100% reproducible and I think it's related to ACPI.

That recent acpi merge seems to have damaged a number of people...

Are you able to test Linus's latest -git spanshot?  See if there's a
difference between -linus and -mm behaviour?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbUKJCVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUKJCVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUKJCVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:21:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:7829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261969AbUKJCVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:21:43 -0500
Date: Tue, 9 Nov 2004 18:21:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re:
 Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041109182129.22a4e9a3.akpm@osdl.org>
In-Reply-To: <20041110020327.GE20754@zaphods.net>
References: <20041103222447.GD28163@zaphods.net>
	<20041104121722.GB8537@logos.cnet>
	<20041104181856.GE28163@zaphods.net>
	<20041109164113.GD7632@logos.cnet>
	<20041109223558.GR1309@mail.muni.cz>
	<20041109144607.2950a41a.akpm@osdl.org>
	<20041109235201.GC20754@zaphods.net>
	<20041110012733.GD20754@zaphods.net>
	<20041109173920.08746dbd.akpm@osdl.org>
	<20041110020327.GE20754@zaphods.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Schmidt <zaphodb@zaphods.net> wrote:
>
> > As for the application collapse: dunno.  Maybe networking broke.  It would
>  > be interesting to test Linus's current tree, at
>  > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.10-rc1-bk19.gz
>  Will try that tomorrow. Would you suggest printing out show_free_areas();
>  there too? I don't know what kind of an overhead that will generate on
>  subsequent stack traces.

I don't think it'd help much - we know what's happening.

It would be interesting to keep increasing min_free_kbytes, see if you can
characterise the system's response to this setting.

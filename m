Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVGOT0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVGOT0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVGOTY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:24:28 -0400
Received: from bay108-dav7.bay108.hotmail.com ([65.54.162.79]:10260 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261678AbVGOTWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:22:35 -0400
Message-ID: <BAY108-DAV714C888634D31F28B5A5D93D00@phx.gbl>
X-Originating-IP: [65.54.162.200]
X-Originating-Email: [multisyncfe991@hotmail.com]
Reply-To: <multisyncfe991@hotmail.com>
From: <multisyncfe991@hotmail.com>
To: <linux-kernel@vger.kernel.org>
References: <BAY108-DAV14071EF16A4482FB4B691593D10@phx.gbl> <20050714051653.GP8907@alpha.home.local> <BAY108-DAV7F3CC1BA8D84C5323469193D10@phx.gbl>
Subject: Volatile vs Non-Volatile Spin Locks on SMP.
Date: Fri, 15 Jul 2005 12:22:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 15 Jul 2005 19:22:33.0033 (UTC) FILETIME=[8CBBEB90:01C58972]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

By using volatile keyword for spin lock defined by in spinlock_t, it seems 
Linux choose to always
reload the value of spin locks from cache instead of using the content from 
registers. This may be
helpful for synchronization between multithreads in a single CPU.

I use two Xeon cpus with HyperThreading being disabled on both cpus. I think 
the MESI
protocol will enforce the cache coherency and update the spin lock value 
automatically between
these two cpus. So maybe we don't need to use the volatile any more, right?

Based on this, I rebuilt the Intel e1000 Gigabit network card driver with 
volatile being removed,
but I didn't notice any performance improvement.

Any idea about this,

Thanks a lot,

Liang




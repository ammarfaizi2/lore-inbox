Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263707AbTDDOZW (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTDDOSP (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:18:15 -0500
Received: from popmail.goshen.edu ([199.8.232.22]:57002 "EHLO mail.goshen.edu")
	by vger.kernel.org with ESMTP id S263682AbTDDOPZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:15:25 -0500
Subject: RE: RAID 5 performance problems
From: Ezra Nugroho <ezran@goshen.edu>
To: Jonathan Vardy <jonathan@explainerdc.com>
Cc: "Peter L. Ashford" <ashford@sdsc.edu>,
       Jonathan Vardy <jonathanv@explainerdc.com>,
       Stephan van Hienen <raid@a2000.nu>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <73300040777B0F44B8CE29C87A0782E101FA988F@exchange.explainerdc.com>
References: <73300040777B0F44B8CE29C87A0782E101FA988F@exchange.explainerdc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 04 Apr 2003 09:39:09 -0500
Message-Id: <1049467150.30062.6215.camel@ezran.goshen.edu>
Mime-Version: 1.0
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hdc: host protected area => 1
> hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
> UDMA(33)


Your hdc is still running at udma(33). This is also part of the raid,
right? This will slow the whole thing down since in raid 5 write is done
to all disks simultaneously. Before the system finishes writing to the
slow drive, the write is not done yet.




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTB0X1D>; Thu, 27 Feb 2003 18:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTB0X1D>; Thu, 27 Feb 2003 18:27:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61608 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267284AbTB0X1B>;
	Thu, 27 Feb 2003 18:27:01 -0500
Date: Thu, 27 Feb 2003 15:32:43 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-Id: <20030227153243.7e7c08f3.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
References: <39710000.1045757490@[10.10.2.4]>
	<Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| A sorted list of bad stack users (more than 256 bytes) in my default build
| follows. Anybody can create their own with something like
| 
| 	objdump -d linux/vmlinux |
| 		grep 'sub.*$0x...,.*esp' |
| 		awk '{ print $9,$1 }' |
| 		sort > bigstack
| 
| and a script to look up the addresses.
| 
| That ide_unregister() thing uses up >2kB in just one call! And there are 
| several in the 1.5kB range too, with a long list of ~500 byte offenders.
| 
| Yeah, and this assumes we don't have alloca() users or other dynamic 
| stack allocators (non-constant-size automatic arrays). I hope we don't 
| have that kind of crap anywhere..

Keith Owens did such a script over 1 year ago.  It's available from
  http://kernelnewbies.org/scripts/check-stack.sh
It also identifies (flags) dynamic stack allocation.
(course, I can't read Keith's as well as I can Linus's)

--
~Randy

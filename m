Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTKKFkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTKKFkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:40:40 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:35832 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S264257AbTKKFki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:40:38 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110205443.6422259f.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
	 <1068523328.25805.97.camel@soul.jpj.net>
	 <20031110202819.7e7433a8.akpm@osdl.org>
	 <1068524657.25804.110.camel@soul.jpj.net>
	 <20031110205443.6422259f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068528589.22809.153.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Nov 2003 00:29:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 23:54, Andrew Morton wrote:

> OK, the IO rates are obviously very poor, and the context switch rate is
> suspicious as well.  Certainly, testing with the single disk would help.

I pulled the secondary, reconfigured to single drives and rebooted. All
is now well, performance is right where it should be.


 0  0      0 1475924   7052  42384    0    0     0     0 1015     6
 0  0      0 1475284   7076  42360    0    0     0   156 1041   311
 0  0      0 1475284   7076  42360    0    0     0     0 1016    12
 0  0      0 1475284   7076  42360    0    0     0     0 1026    30
 2  0      0 1252628   7300 258852    0    0     8 37240 1157   119
 0  3      0 1027284   7524 478064    0    0     8 66016 1441   317
 1  3      0 818132   7728 682948    0    0     4 70752 1439   202 
 1  3      0 593236   7944 901760    0    0     4 64576 1452    92 
 0  4      0 531412   8008 961876    0    0     4 63680 1434    97 
 1  3      0 455604   8084 1035648    0    0     4 69312 1464   103
 0  4      0 388148   8148 1101272    0    0     0 66328 1442   141
 0  4      0 308172   8228 1179120    0    0     4 69964 1446   100
 0  5      0 257548   8280 1228436    0    0     4 67548 1460   148
 1  2      0 195340   8356 1288948    0    0     0 63444 1452   291
 0  5      0 115532   8436 1367884    0    0     4 73896 1448   319


-Paul




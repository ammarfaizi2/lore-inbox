Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUG3OGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUG3OGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUG3OGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:06:50 -0400
Received: from mail1.slu.se ([130.238.96.11]:967 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S267682AbUG3OGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:06:09 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16650.21955.869485.332365@robur.slu.se>
Date: Fri, 30 Jul 2004 16:05:55 +0200
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0407301530130.23039-100000@silmu.st.jyu.fi>
References: <16650.4736.456106.603065@robur.slu.se>
	<Pine.LNX.4.44.0407301530130.23039-100000@silmu.st.jyu.fi>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pasi Sjoholm writes:

 > I don't remember if I have said this but when the ksoftirqd has started to 
 > take all the cpu-time there is no way to stop it excluding booting 
 > computer. You can kill or stop all the processes which are taking your 
 > cpu-time (ie. source compiling) but network wont start to work or neither 
 > there is no free cpu-time for use because ksoftirqd won't stop eating it.

 No you didn't then it seems you are hit by some bug. Have the bug happen.
 Kill userland processes like as you did. Try find out what's running. I would 
 look in /proc/interrupt /proc/net/softnet_stat /proc/net/dev or maybe best to 
 take a profile if possible or Magic SysRq to find out what's looping. Also try
 ifconfig down.

 Cheers.
						--ro

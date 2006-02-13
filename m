Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWBMVq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWBMVq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBMVq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:46:56 -0500
Received: from host-a-002.milc.com.pl ([213.17.132.2]:36252 "EHLO milc.com.pl")
	by vger.kernel.org with ESMTP id S932443AbWBMVqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:46:55 -0500
Date: Mon, 13 Feb 2006 22:46:51 +0100
From: Yoss <bartek@milc.com.pl>
To: linux-kernel@vger.kernel.org
Subject: Memory leak in 2.4.33-pre1?
Message-ID: <20060213214651.GA27844@milc.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (milc.com.pl [127.0.0.1]); Mon, 13 Feb 2006 22:46:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
My server have lost about ~300MB of RAM. Details:

webcache:~# uname -a
Linux webcache 2.4.33-pre1 #2 Wed Feb 8 18:26:44 CET 2006 i686 GNU/Linux

No other patches. Only basic elements needed to work in network
enviroment.
	
webcache:~# dmesg | grep MEM
127MB HIGHMEM available.
896MB LOWMEM available.

When I count memmory used by processes (column SIZE from ps or RES from
top) there is about 650MB used. (There is only squid, named and basic
system deamons running on that host). But:

webcache:~# free -m
            total       used       free     shared  buffers    cached
Mem:         1009        996         13          0       18        32
-/+ buffers/cache:       945         64
Swap:        1953          0       1952


So there is missing about ~300MB.
If anyone wants to have more detailed info feel free to ask.

-- 
Bart³omiej Butyn aka Yoss
Nie ma tego z³ego co by na gorsze nie wysz³o.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTJDAGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 20:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbTJDADt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 20:03:49 -0400
Received: from [207.175.35.50] ([207.175.35.50]:5819 "EHLO
	alpha.eternal-systems.com") by vger.kernel.org with ESMTP
	id S261559AbTJDADh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 20:03:37 -0400
Message-ID: <3F7E0DFF.2030404@eternal-systems.com>
Date: Fri, 03 Oct 2003 17:02:07 -0700
From: Vishwas Raman <vishwas@eternal-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Accessing tcp socket information from within a module
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to write a module in the 2.4.20 kernel, which will do pretty 
much a small subset of what netstat does from the user-space. All 
netstat does is read from /proc/net/tcp to get hold of info regarding 
TCP sockets in the system.

I want to be able to find out what are all the open tcp sockets in the 
system and the states they are in. In the TCP implementation in the 
kernel, this information lies in a set of hash tables. I tried to access 
one of these hash tables "tcp_hashinfo" from within my kernel moule. But 
this symbol is exported by netsyms.c in the kernel only if IPV6 or 
KHTTPD or is turned on, and since I have my kernel built without IPV6 or 
KHTTPD, I cannot access these hashtables.

Is there some way of accessing the information of all open tcp sockets 
in the system, other than having to turn one of IPV6 or KHTTPD on?

Thanks in advance for any help.

-Vishwas.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293440AbSCOWhK>; Fri, 15 Mar 2002 17:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293439AbSCOWhA>; Fri, 15 Mar 2002 17:37:00 -0500
Received: from mail.webmaster.com ([216.152.64.131]:46299 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293434AbSCOWgu> convert rfc822-to-8bit; Fri, 15 Mar 2002 17:36:50 -0500
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Fri, 15 Mar 2002 14:36:48 -0800
Subject: RFC2385 (MD5 signature in TCP packets) support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020315223649.AAA27488@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Has anyone made a patch or done any work on RFC2385 support for Linux? I'm 
willing to code the subset of it that I need if there's a general consensus 
that my approach is reasonable.

	I don't plan to add a table of IPs/ports and have the kernel automatically 
invoke authentication for those IPs/ports. This is mostly because I don't 
need this functionality, but if it's felt that this is the only way to go, 
then I'll reconsider my plans.

	I plan to add a socket option. You use it after you bind for inbound TCP 
connections and before you connect for outbound. You simply set the key to be 
used on the connection in the sockopt call. There would also be an option to 
allow/disallow unkeyed connections (should the key be optional or mandatory). 
Also, a get socket option would allow you to determine whether the key was 
being used or not.

	One limitation of this approach is that for inbound connections, you can't 
have a different password for multiple hosts that might connect to you.

	My interest for this is mostly for Zebra to be able to make secure BGP 
connections, so I would also contribute a patch for Zebra to support this 
feature on Linux.

	Am I wasting my time? Is there interest?

-- 
David Schwartz
<davids@webmaster.com>



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTJAFdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbTJAFdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:33:44 -0400
Received: from mail1.inspire.net.nz ([203.114.128.8]:17120 "EHLO
	mail1.inspire.net.nz") by vger.kernel.org with ESMTP
	id S261931AbTJAFdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:33:42 -0400
Message-ID: <3F7B103A.5070502@inspire.net.nz>
Date: Wed, 01 Oct 2003 17:34:50 +0000
From: Richard Greaney <greaneyr@inspire.net.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ethernet speed problems
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two .config files. One I have developed from scratch and is used 
on a Debian server at work. The other is more or less a stock kernel 
built by Gentoo 1.4, but with some hardware support removed.

These two .config files have been causing me a lot of grief lately. I 
can compile the same 2.4.22 source tree and simply change the .config 
file and hardware support becomes more than binary.  The Debian-born 
kernel has support for the ethernet card (RTL8139C) but when tested, it 
only operates at around 10Mbps, even though the network is running at 
100. mii-tool reports it to be running at 100Mbps FD but in reality this 
is not the case. The Gentoo-born kernel has no problems and runs at a 
true 100Mbps. After checking through the syslog whilst using the 
Debian-born kernel, I see no error messages relating to this problem.

The obvious thing to do would be to start with the Gentoo-born .config 
file and modify as required so as to add in the required hardware 
support that the Debian-born .config file has. However, something in the 
Gentoo-born .config file has been set that prevents PPP Filtering from 
being set. It's just not an option whilst running make menuconfig.

Can anybody think of any reason why an ethernet card might work at a 
slower speed with one kernel than it does with another?

What about the PPP-Filtering support? Where is this being disabled 
during the make menuconfig?


Please CC me with any replies

Thanks in advance
Richard Greaney


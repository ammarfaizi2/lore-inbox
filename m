Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTHTRaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTHTRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:30:46 -0400
Received: from mail32.megamailservers.com ([216.251.36.32]:11527 "EHLO
	mail32.megamailservers.com") by vger.kernel.org with ESMTP
	id S262069AbTHTRao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:30:44 -0400
X-Authenticated-User: jiri.gaisler.com
Message-ID: <3F43B061.3010805@gaisler.com>
Date: Wed, 20 Aug 2003 19:31:13 +0200
From: Jiri Gaisler <jiri@gaisler.com>
Reply-To: jiri@gaisler.com
Organization: Gaisler Research
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Clean kernel patch for LEON/SPARC
References: <3F43551A.1060901@gaisler.com> <20030820123311.A6511@devserv.devel.redhat.com>
In-Reply-To: <20030820123311.A6511@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

 > The serial has to go to Russell King, but I can look, too.
 > Best of all is to cc to linux-kernel.
 >
 > About Ethernet, it probably ought to go to netdev@oss.sgi.com.
 > I am not quite sure.
 >

I have made three patches that makes up the leon/sparc port
for linux-2.5.75:


* linux-2.5.75_kernel_only.diff  - leon support in kernel

* linux-2.5.75_open_eth.diff     - opencores ethernet driver

* linux-2.5.75_leon_uart.diff    - leon uart driver


The total size is about 150 Kbyte, so to avoid a large email
the patches can be downloaded from:

http://www.gaisler.com/patches.html


I don't have Russell King's email address, maybe you could
forward this mail to him?

> Did you guys figure out the cause of the severe problem
> with cache corruption?

Yes, this was a virtual address aliasing problem. Leon2 has
virtual caches but the MMU has no aliasing detection, so we
are forced to flush the cache on each task switch. Our next
processor (leon3) will have to switch to either physical caches
or have some form of aliasing detection ...

Regards, Jiri.
-- 
-------------------------------------------------------------------------
Gaisler Research, Stora Nygatan 13, 41108 Goteborg, Sweden, +46-31802405
fax: +46-31802407 email: info@gaisler.com, home page: www.gaisler.com
-------------------------------------------------------------------------


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVCFS0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVCFS0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVCFS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:26:37 -0500
Received: from dns2.EURNetCity.net ([80.68.196.9]:29712 "EHLO
	dns2.EurNetCity.NET") by vger.kernel.org with ESMTP id S261461AbVCFSXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:23:13 -0500
Message-ID: <422B4A66.707@route-add.net>
Date: Sun, 06 Mar 2005 19:22:30 +0100
From: Alessandro Selli <dhatarattha@route-add.net>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.7.5) Gecko/20050105
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pedro Larroy <piotr@larroy.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Vanilla kernel >=2.4.28-rc2 incompatibility with ADSL modem Dlink
 DSL-G300+
References: <422B3F60.8020303@route-add.net> <20050306180833.GA4398@larroy.com>
In-Reply-To: <20050306180833.GA4398@larroy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-EurNetCity-MailScanner-Information: Please contact the ISP for more information
X-EurNetCity-MailScanner: Found to be clean
X-MailScanner-From: dhatarattha@route-add.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy wrote:

[....]

>>I tried changing the wiring, I swapped the ethernet ports the LAN and
>>ADSL modem where connected to, I swapped the modem with an identical one
>>from a colleague of mine, I upgraded to kernel 2.4.29 all to no avail.
>>  I then tried the 2.4.28-rc{1,2,3} kernels, and I found the 2.4.28-rc1
>>not to exhibit the problem, that manifests itself on the 2.4.28-rc{2,3}
>>kernels.
>>  The problem is sparc-specific, a PC with the very same configuration
>>(Debian stable, plain vanilla kernels etc.) did not suffer any
>>connection drops.

   I forgot to mention: as I was suggested to do by other people, I 
changed the settings of the two parameters:

/proc/sys/net/ipv4/tcp_ecn
/proc/sys/net/ipv4/tcp_default_win_scale

   This did not help, though.

> I have seen similar problems due to high sequence numbers on the tcp
> packets on some adsl routers. Took a while to discover that since the
> connection misteriously ceased to work from some boxes after some time
> transmitting data ok. Looks like some manufacturers such as efficient
> networks adsl routers, doesn't follow the standards.
>
> I'd suggest running tcpdump and doing some observation.

   Thank you for your reply, I'll do as you suggested.

-- 
Alessandro Selli
Tel: 340.839.73.05
http://alessandro.route-add.net

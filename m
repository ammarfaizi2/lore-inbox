Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWARCj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWARCj2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWARCj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:39:28 -0500
Received: from mail.dvmed.net ([216.237.124.58]:47793 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964849AbWARCj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:39:26 -0500
Message-ID: <43CDAA58.5000904@pobox.com>
Date: Tue, 17 Jan 2006 21:39:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: net 2.6.16-rc1: multiple ipv6 failures
Content-Type: multipart/mixed;
 boundary="------------040705070602060605070104"
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Just moved my firewall/gateway from 2.6.15 to
	2.6.16-rc1, and had a couple IPv6-related problems really bite me. 1)
	radvd runs at 100% CPU (CentOS 4 userland, 2.6.15 worked fine). I had
	to kill it. > Jan 17 21:24:43 pretzel ifup: done. > Jan 17 21:24:44
	pretzel ifup: radvd control enabled, but config is not complete > Jan
	17 21:24:50 pretzel radvd[4264]: version 0.7.2 started > Jan 17
	21:24:44 pretzel ifup: ERROR : [ipv6_trigger_radvd] Given pidfile
	'/var/run/radvd/radvd.pid' doesn't exist, cannot send trigger to radvd
	> Jan 17 21:24:50 pretzel radvd: radvd startup succeeded [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705070602060605070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Just moved my firewall/gateway from 2.6.15 to 2.6.16-rc1, and had a
couple IPv6-related problems really bite me.

1) radvd runs at 100% CPU (CentOS 4 userland, 2.6.15 worked fine).  I
had to kill it.

> Jan 17 21:24:43 pretzel ifup:  done.
> Jan 17 21:24:44 pretzel ifup: radvd control enabled, but config is not complete
> Jan 17 21:24:50 pretzel radvd[4264]: version 0.7.2 started
> Jan 17 21:24:44 pretzel ifup: ERROR    : [ipv6_trigger_radvd] Given pidfile '/var/run/radvd/radvd.pid' doesn't exist, cannot send trigger to radvd
> Jan 17 21:24:50 pretzel radvd: radvd startup succeeded


2) bind fails (which everyone on my network immediately noticed, and
complained about).

> Jan 17 21:29:04 pretzel named[5110]: loading configuration from '/etc/named.conf'
> Jan 17 21:29:04 pretzel named[5110]: /proc/net/if_inet6:sscanf() -> 1 (expected 6)
> Jan 17 21:29:04 pretzel named[5110]: interfacemgr.c:827: unexpected error:
> Jan 17 21:29:04 pretzel named[5110]: interface iteration failed: failure
> Jan 17 21:29:04 pretzel named[5110]: not listening on any interfaces
> Jan 17 21:29:04 pretzel named[5110]: command channel listening on 127.0.0.1#953
> Jan 17 21:29:04 pretzel named[5110]: /proc/net/if_inet6:sscanf() -> 1 (expected 6)
> Jan 17 21:29:04 pretzel named[5110]: interfacemgr.c:827: unexpected error:
> Jan 17 21:29:04 pretzel named[5110]: interface iteration failed: failure

Again, 2.6.15 works just fine.

Config attached.  32-bit x86 uniprocessor w/ HT (thus, SMP config).

	Jeff




--------------040705070602060605070104
Content-Type: application/x-bzip2;
 name="config.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.txt.bz2"

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
--------------040705070602060605070104--

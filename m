Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272798AbTHKQKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272790AbTHKQHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:07:48 -0400
Received: from janus.zeusinc.com ([205.242.242.161]:10005 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S272774AbTHKQFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:05:46 -0400
Subject: IPsec and racoon on 2.6.0-testX
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060617851.3133.31.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 11 Aug 2003 12:05:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over the weekend I decided to try to convert my last 2.4 based system at
home to 2.6.  This system is a simple router/firewall to connect my
internal network to the Internet and office network via my DSL Internet
connection.  It's a good old white-box, AMD-K6-2 333Mhz system running
Redhat 9 + updates and SuperFreeS/WAN for IPsec VPN connectivity to my
office network.

Anyway, everything works fine, except of course IPsec.  Last week I had
finally managed to get IPsec working on my laptop running
2.6.0-test2-mm1 and using ipsec-tool 0.2.2 so I thought this would be
pretty simple since I already had a known working config.

Unfortunately I'm not so lucky.  I've configured the system with the
same basic options as my laptop (a Dell C810) but of course they are not
very similar systems so I selected certain things different such as the
CPU type (the laptops and P3, the home system an AMD-K6-2), and disabled
PCMCIA, APM, and other such features that are useless for the desktop
system, but networking options and such are the same.

The system boots up fine, I can use setkey to add policies, but when I
run racoon (with -F -d -d to get debugging info) the system loads all
the modules, parses the config file successfully, and then hangs before
it even binds to any IP address.  I have to kill -9 to force it to
exit.  The same exact racoon works properly on my laptop.

This may not be a kernel issue, but I'm posting here because I'm not
sure where to post at.  The ipsec-tools-devel list seems almost
non-existent (maybe it's just down, it seems Sourceforge is having
issues).  I was able to reproduce the problem on another system which is
also a K6-2, so I'm wondering if this could somehow be an issue as it
seems to work fine on my Athlon and my P3 system.  Still, IPsec should
certainly work with this system, it worked great with 2.4 and FreeS/WAN.

Any help or direction would be greatly appreciated.

Thanks,
Tom



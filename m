Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUITQ0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUITQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUITQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:26:44 -0400
Received: from pyxis.pixelized.ch ([213.239.200.113]:32160 "EHLO
	pyxis.pixelized.ch") by vger.kernel.org with ESMTP id S266758AbUITQ0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:26:30 -0400
Message-ID: <414F02AB.4080208@debian.org>
Date: Mon, 20 Sep 2004 18:17:47 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston> <414D42F6.5010609@softhome.net> <20040919140034.2257b342.Ballarin.Marc@gmx.de> <414D96EF.6030302@softhome.net> <20040919171456.0c749cf8.Ballarin.Marc@gmx.de> <cikaf1$e60$1@sea.gmane.org> <20040919173035.GA2345@kroah.com> <cilf99$ams$1@sea.gmane.org>
In-Reply-To: <cilf99$ams$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alexander E. Patrakov wrote:
 >
> Implementation of various logical primitives. E.g., I use GPRS and want 
> to start pppd during the boot process (i.e., an always-on link), but 
> after the following things:
> 
> 1) /dev/ttyS0 has been created
> 2) /dev/ppp has been created
> 3) modules for line disciplines and PPP compression have been preloaded 
> (e.g. by grepping modules.alias for tty-ldisc and ppp-compress) and are 
> ready for use by pppd
> 4) firewall rules have been applied
> 
> How to "AND" these things together in a /etc/dev.d scriptlet?
and

5) /tmp is read-write
6) /var is mounted
7) log daemon is already running

but I think they can implemented with a waiting queue or other
user-space implementation.
Hmm wait, we will miss the event between udev loaded and
/var mounted and dev.d started!

ciao
	cate

PS: I hope this discussion will start project of re-thinking the
boot/init.d method.


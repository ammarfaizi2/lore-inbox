Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTIAMp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 08:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTIAMp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 08:45:28 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:17051
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262868AbTIAMp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 08:45:27 -0400
Message-ID: <3F533FB6.8030301@trash.net>
Date: Mon, 01 Sep 2003 14:46:46 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel@schottelius.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bastian@schottelius.org
Subject: Re: [BUGS?: 2.6.0test4] iptables and tc problems
References: <20030901122818.GE5524@schottelius.org>
In-Reply-To: <20030901122818.GE5524@schottelius.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:

>Then trying to match the ftp connections
>bruehe:~#  iptables -A OUTPUT -m owner --uid-owner 0 -j ACCEPT   
>iptables: Invalid argument
>bruehe:~# iptables -t mangle -A POSTROUTING -o ppp0 -m owner --uid-owner 1001 -j MARK --set-mark 55
>iptables: Invalid argument
>
>Why does iptables or the kernel not accept that?
>

There was a change in the owner match some (long) time ago which
broke the ABI. You probably need to recompile iptables.

Regards,
Patrick


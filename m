Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVIQLJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVIQLJX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVIQLJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:09:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8590 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751064AbVIQLJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:09:22 -0400
Date: Sat, 17 Sep 2005 13:08:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Harald Welte <laforge@netfilter.org>
cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [HELP] netfilter Kconfig dependency nightmare
In-Reply-To: <20050917080714.GV8413@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.61.0509171306290.3743@scrub.home>
References: <20050916021451.3012196c.akpm@osdl.org>
 <20050916191959.GN8413@sunbeam.de.gnumonks.org> <39e6f6c705091617514457eded@mail.gmail.com>
 <20050917012315.GA29841@mandriva.com> <20050917080714.GV8413@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 17 Sep 2005, Harald Welte wrote:

> ip_conntrack == CONFIG_IP_NF_CONNTRACK
> nfnetlink == CONFIG_NETFILTER_NETLINK
> ip_conntrack_netlink == CONFIG_IP_NF_CONNTRACK_NETLINK
> 
> If nfnetlink == N, ip_conntrack can be N or M or Y
> If nfnetlink == M, ip_conntrack can be N or M
> If nfnetlink == Y, ip_conntrack can be Y or M

Where is the requirement for the last one coming from?

> If ip_conntrack == N && nfnetlink == N, ip_conntrack_netlink must be N
> If ip_conntrack == N && nfnetlink == M, ip_conntrack_netlink must be N
> If ip_conntrack == N && nfnetlink == Y, ip_conntrack_netlink must be N
> 
> If ip_conntrack == M && nfnetlink == N, ip_conntrack_netlink must be N 
> If ip_conntrack == M && nfnetlink == M, ip_conntrack_netlink can N or M
> If ip_conntrack == M && nfnetlink == Y, ip_conntrack_netlink can N or M
> 
> if ip_conntrack == Y && nfnetlink == N, ip_conntrack_netlink must be N
> if ip_conntrack == Y && nfnetlink == M, ip_conntrack_netlink can N or M
> if ip_conntrack == Y && nfnetlink == Y, ip_conntrack_netlink can N, M or Y

That looks like a normal ip_conntrack && nfnetlink.

bye, Roman

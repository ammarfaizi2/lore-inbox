Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTLKI0r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTLKIZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:25:38 -0500
Received: from marasystems.com ([213.150.153.194]:60307 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S264463AbTLKIZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:25:34 -0500
Date: Thu, 11 Dec 2003 09:25:17 +0100 (CET)
From: Henrik Nordstrom <hno@marasystems.com>
X-X-Sender: henrik@filer.marasystems.com
To: Harald Welte <laforge@netfilter.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Lee <mukansai@emailplus.org>,
       <scott.feldman@intel.com>, <netfilter-devel@lists.netfilter.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
In-Reply-To: <20031211072608.GF22826@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.44.0312110921540.23401-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Harald Welte wrote:

> yes, this is certainly a problem - but not with conntrack, only with
> nat.  So maybe we should add a safeguard, preventing
> iptables_nat/ipchains/ipfwadm from being loaded when TSO on any
> interface is enabled?  Or at least print a warining in syslog?

TSO can be enabled while NAT is running so you better do this in the 
packet flow or if there is a suitable notifier hook that can be used.

Most firewalls etc load the ruleset before activating the 
interfaces, i..e before even loading the nic drivers, so there is no 
interfaces to look at when iptables_nat is loaded.

Regards
Henrik


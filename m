Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVA0UqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVA0UqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVA0Unq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:43:46 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:3845
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261176AbVA0UkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:40:13 -0500
Date: Thu, 27 Jan 2005 12:40:12 -0800
From: Phil Oester <kernel@linuxace.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050127204012.GA14518@linuxace.com>
References: <20050123023248.263daca9.akpm@osdl.org> <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127183745.GA13365@linuxace.com> <20050127192504.D3036@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127192504.D3036@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 07:25:04PM +0000, Russell King wrote:
> Can you provide some details, eg kernel configuration, loaded modules
> and a brief overview of any netfilter modules you may be using.
> 
> Maybe we can work out what's common between our setups.

Vanilla 2.6.10, though I've been seeing these problems since 2.6.8 or
earlier.  Netfilter running on all boxes, some utilizing SNAT, others
not -- none using MASQ.  This is from a box running no NAT at all,
although has some other filter rules:

# wc -l /proc/net/rt_cache ; grep dst_cache /proc/slabinfo
     50 /proc/net/rt_cache
ip_dst_cache       84285  84285

Also with uptime of 26 days.  

These boxes are all running the quagga OSPF daemon, but those that
are lightly loaded are not exhibiting these problems.

Phil

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161113AbWJDSLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161113AbWJDSLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161930AbWJDSLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 14:11:12 -0400
Received: from hera.kernel.org ([140.211.167.34]:59350 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1161113AbWJDSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 14:11:10 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: ip_conntrack_core - possible memory leak in 2.4
Date: Wed, 4 Oct 2006 11:09:57 -0700
Organization: OSDL
Message-ID: <20061004110957.032ac75e@freekitty>
References: <20061004180201.GA18386@nomi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1159985397 30702 10.8.0.54 (4 Oct 2006 18:09:57 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 4 Oct 2006 18:09:57 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.5; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 20:02:01 +0200
onovy@nomi.cz wrote:

> hi,
> 
> i have there MontaVista based router, with 2.4.17_mvl21-malta-mips_fp_le
> kernel. I think, there is memory leak in ip_conntrack code. There are
> eta 500 conntrack connection all the time. But after some day i get
> "ip_conntrack: table full" in kmsg.
> /proc/sys/net/ipv4/netfilter/ip_conntrack_max have 3072 value.
> grep ip_conntrack /proc/slabinfo
> ip_conntrack        3006   3250    384  319  325    1
> ^^ there are 3006 allocated conntracks
> cat /proc/net/ip_conntrack | wc -l
> 30
> ^^ in table are only 30 lines.
> 
> Acording to this:
> http://lists.netfilter.org/pipermail/netfilter-devel/2004-May/015628.html
> i don't think, this is fixed in 2.4 tree, but i can't test it with newer
> version.
> 
> Thanks

You paid for an expensive vendor kernel. Use their support, and
make them fix it.

-- 
Stephen Hemminger <shemminger@osdl.org>

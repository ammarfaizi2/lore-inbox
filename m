Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWJEUHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWJEUHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWJEUHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:07:08 -0400
Received: from 1wt.eu ([62.212.114.60]:16132 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751125AbWJEUHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:07:06 -0400
Date: Thu, 5 Oct 2006 21:30:28 +0200
From: Willy Tarreau <w@1wt.eu>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@lists.netfilter.org
Subject: Re: ip_conntrack_core - possible memory leak in 2.4
Message-ID: <20061005193028.GC5050@1wt.eu>
References: <20061004180201.GA18386@nomi.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004180201.GA18386@nomi.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[netfilter-devel list CC'd]

Hello,

On Wed, Oct 04, 2006 at 08:02:01PM +0200, onovy@nomi.cz wrote:
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

Well, I know several old 2.4 netfilter systems running around and which
process between 100 and 200 millions of sessions a day with peak hours
around 4000 sessions/s. They might have been rebooted twice in 3 years,
and they still work without a glitch. So I clearly don't think that the
problem mentionned above is present in plain 2.4. It might be a very
old bug in you rather old kernel, or one specific to some patches in
your distro's kernel (BTW, I would be surprized you wouldn't find
anything more recent than 2.4.17).

Best regards,
Willy


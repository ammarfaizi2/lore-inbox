Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUAMKKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUAMKKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:10:20 -0500
Received: from pD9E56EEE.dip.t-dialin.net ([217.229.110.238]:5761 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S263909AbUAMKKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:10:17 -0500
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: demiurg@ti.com, linux-kernel@vger.kernel.org
Subject: Re: skb fragmentation
From: Andi Kleen <ak@muc.de>
Date: Tue, 13 Jan 2004 11:10:02 +0100
In-Reply-To: <1dtvl-1w4-5@gated-at.bofh.it> (Muli Ben-Yehuda's message of
 "Tue, 13 Jan 2004 11:00:19 +0100")
Message-ID: <m3ptdotb0l.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <1dszh-7Gs-5@gated-at.bofh.it> <1dtvl-1w4-5@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:

> How? build a fragmented skb on the receive path and send it
> upwards. Last I looked at the relevant code (2.4.something), however,
> the tcp/ip stack called skb_linearize() on the skb on its way up, so

Actually the main protocols (TCP,UDP,RAW) work with fragmented skbs. The
skb_linearize() users are mostly netfilter modules and some obscure
older protocols. Most of that has been fixed in 2.6.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbULOK6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbULOK6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbULOK61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:58:27 -0500
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:48106
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S262328AbULOK5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:57:24 -0500
Date: Wed, 15 Dec 2004 10:56:46 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steve Whitehouse <SteveW@ACM.org>, linux-decnet-user@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/decnet/: misc possible cleanups
Message-ID: <20041215105646.GB27420@tykepenguin.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Steve Whitehouse <SteveW@ACM.org>,
	linux-decnet-user@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20041214125838.GC23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20041214125838.GC23151@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 01:58:38PM +0100, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - dn_fib.c: remove the write-only global variable dn_fib_info_cnt
> - dn_fib.c: remove the unused global function dn_fib_rt_message
> - dn_neigh.c: remove the unused global function dn_neigh_pointopoint_notify
> - dn_timer.c: remove the fast timer code that isn't used
> 
> Please review and comment on this patch.
> 

Looks fine to me. I'm quite happy to lose the fast ack code - unused code is
only a confusion to those reading it IMHO. If we do the delayed-ack code in
future then it's easy enough to reinstate.

Thanks.

-- 

patrick

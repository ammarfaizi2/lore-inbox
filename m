Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUG3Rcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUG3Rcf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267766AbUG3RcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:32:03 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:41116 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S267756AbUG3R3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:29:54 -0400
Date: Fri, 30 Jul 2004 19:29:39 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: List of pending v2.4 kernel bugs
Message-ID: <20040730172939.GA24235@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040720142640.GB2348@dmt.cyclades> <20040721112336.GA9537@k3.hellgate.ch> <20040730155613.GD2748@logos.cnet> <410A8077.7020308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410A8077.7020308@pobox.com>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 13:08:07 -0400, Jeff Garzik wrote:
> I am worried because this specific area of code has been "fixed" at 
> least twice in recent memory, making Roger's changes the third attempt 
> to address this sort of problem.

I wasn't aware of that. At least for via-rhine, I tracked the history
down back when I investigated the bug. IIRC the bug was introduced when
set_bit was replaced.

> I would really like to see verification of patches on the hardware 
> affected (big endian), as well as tests on little endian to ensure 
> nothing breaks, before applying them.

As I have pointed out before, I verified for Linux 2.6 that without
the patch, multicasting worked on x86 but not on ppc, and that with
the patch multicasting did work on both platforms. If in 2.4 you prefer
stability over fixes for bugs nobody complained about that's fine by
me, though.

I am more concerned with the remaining drivers that at first glance
looked like they had the same problem (atp, winbond, tulip_core) in
2.6. Did anyone ever test these, or try the patches I posted? The only
feedback I remember was on typhoon, which looked okay to me and indeed
turned out to work.

Roger

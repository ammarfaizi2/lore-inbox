Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTIKSsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTIKSsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:48:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:46482 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261463AbTIKSrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:47:35 -0400
Subject: Re: Linux on Intel Server Board SE7501WV2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yaoping Ruan <yruan@CS.Princeton.EDU>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.55.0309111338120.28288@oakley.CS.Princeton.EDU>
References: <Pine.GSO.4.55.0309111338120.28288@oakley.CS.Princeton.EDU>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063305980.3605.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 19:46:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 18:39, Yaoping Ruan wrote:
> We plan to install Linux (2.4.21 and later with epoll patch) on an Intel
> Server Board SE7501WV2 with 1 XEON 2.4GHz CPU, 4GB PC2100 DDR memory, and
> a Seagate 120GB ATA 7200RPM harddisk, and use the server box for high
> demand SpecWeb99 tests. Does anyone have any experience on this Server
> Board, and see any compatibility problem here?

It ought to run Specweb99 nicely if you load a tux enabled kernel and
tux enabled web servers on it. The lack of a real disk I/O subsystem may
well hurt a lot though

> An other question about this box is the two on-board Gigabit Network
> Controller. Do they work fine on Linux?

I believe so. Make sure the chips on the board support zero copy and
also interrupt mitigation, preferably also that NAPI capable drivers are
used if you are benching.


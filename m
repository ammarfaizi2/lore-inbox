Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFHKZW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 06:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTFHKZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 06:25:22 -0400
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:52745 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id S261365AbTFHKZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 06:25:20 -0400
Date: Sun, 8 Jun 2003 12:38:57 +0200
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: stability issues with 2.4.20-ac1 (was: ethernet-ATM-Router freezing)
Message-ID: <20030608103857.GB12211@torres.ka0.zugschlus.de>
References: <20030222084958.GC23827@torres.ka0.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222084958.GC23827@torres.ka0.zugschlus.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 09:49:58AM +0100, Marc Haber wrote:
> we use Linux to terminate ATM PVCs and to move the traffic coming in
> on the ATM link to Ethernet. We have two parallel machines with
> identical hardware (about two years old), in a Debian GNU/Linux setup
> built in November 2002. Current kernel is 2.4.20-ac1, and the setup
> hasn't been touched since December 2002. One of the machines does the
> work, while the other is waiting to be activated in case of failure.
> Max load is about 6 Mbit, the machines are mostly idle. At least I
> won't call them loaded.
> 
> A few days ago, the "active" machine has started spontaneously
> freezing. The freezes don't happen at times with especially high or
> low load, they don't happan during the same time of day. The freezes
> are complete:
> - no network respose on the ATM link
> - no network response on the Ethernet link
> - no response at all on the system console
> - no error or panic messages on the console
> - no response to Magic SysRq
> - atsar doesn't show any strange patterns in CPU/memory usage
> - syslog doesn't show anything strange
> - mrtg doesn't show anything strange in network load
> 
> Reset button is needed to revive the frozen box.

In the mean time, we started experiencing the same behavior on routers
that have only ethernet interfaces, a web server and my personal
workstation. All machines run kernel 2.4.20-ac1, and downgrading to
2.4.19 seems to solve the problem in all cases. I am now pretty sure
that I am not experiencing bad hardware.

I am now running my personal workstation with 2.4.21-rc7, but cannot
comment on that kernel at the moment.

Are there any known stability issues with 2.4.20-ac1?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVCVQRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVCVQRJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVCVQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:17:09 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:21511
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261399AbVCVQQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:16:59 -0500
Date: Tue, 22 Mar 2005 08:16:57 -0800
From: Phil Oester <kernel@linuxace.com>
To: buakaw@buakaw.homelinux.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: dst cache overflow
Message-ID: <20050322161657.GA18925@linuxace.com>
References: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net> <20050321194022.491060c7.akpm@osdl.org> <1297.192.168.0.37.1111480783.squirrel@buakaw.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297.192.168.0.37.1111480783.squirrel@buakaw.homelinux.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 10:39:43AM +0200, buakaw@buakaw.homelinux.net wrote:
> 
> computer's main job is to be router on small LAN with 10 users and  some
> services like qmail, apache, proftpd, shoutcast, squid, and ices on slack
> 10.1. Iptables and tc are used to limit  bandwiwdth and the two bandwidthd
>  daemons are running on eth0 interface and all the time the cpu is used at
> about 0.4% and additional 12% by ices  when encoding mp3 on demand, and
> the proccess ksoftirqd/0 randomally starts to use 100% of 0 cpu in normal
> situation and one time when the ksoftirqd/0 became crazy i noticed dst
> cache overflow messages in syslog but there are more of thies lines in
> logs  about 5 times in 10 days period

There was a problem fixed in the handling of fragments which caused dst
cache overflow in the 2.6.11-rc series.  Are you still seeing dst cache
overflow on 2.6.11?

Phil

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVGEFNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVGEFNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 01:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVGEFNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 01:13:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33929 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261638AbVGEFNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 01:13:47 -0400
Subject: Re: IBM HDAPS things are looking up
From: Lee Revell <rlrevell@joe-job.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>, Jens Axboe <axboe@suse.de>,
       Shawn Starr <shawn.starr@rogers.com>, Lenz Grimmer <lenz@grimmer.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0507041131390.26084@twinlark.arctic.org>
References: <20050704061713.GA1444@suse.de>
	 <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com>
	 <20050704144634.GQ1444@suse.de> <42C970D1.3090609@linuxwireless.org>
	 <Pine.LNX.4.63.0507041131390.26084@twinlark.arctic.org>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 01:13:44 -0400
Message-Id: <1120540424.17355.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-04 at 11:36 -0700, dean gaudet wrote:
> as for other details it's trivial to lock the daemon in memory and run
> it at nice -4 to get a head start on parking even when at 100% cpu and
> under memory load.
> 

Negative nice values are not the correct solution when dealing with RT
constraints like this, you need SCHED_FIFO.  You can't afford the chance
that the scheduler could decide to run another task due to some internal
heuristic.

Lee


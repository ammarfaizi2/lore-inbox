Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132897AbRBEGJA>; Mon, 5 Feb 2001 01:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132912AbRBEGIu>; Mon, 5 Feb 2001 01:08:50 -0500
Received: from linuxcare.com.au ([203.29.91.49]:21009 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132897AbRBEGIi>; Mon, 5 Feb 2001 01:08:38 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 5 Feb 2001 17:06:43 +1100
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Rusty Russell <rusty@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1
Message-ID: <20010205170643.A8721@linuxcare.com>
In-Reply-To: <E14PcpU-0004U1-00@halfway> <20010205065029.K430@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010205065029.K430@marowsky-bree.de>; from lmb@suse.de on Mon, Feb 05, 2001 at 06:50:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Rusty, what would be needed to "hot-add" CPUs ?

The PPC version at the moment simply locks a cpu in the idle loop
with __cli(); while(1); for cpu down and jumps out of it for cpu up.
Good for testing but not very useful. After talking to paulus we
will use the RTAS cpu stop and cpu start.

In order to bring a new cpu up you will need to duplicate a lot of
the stuff in smp_boot_cpus or else just set up all NR_CPUS of these
structures (eg NR_CPUS idle threads etc) at boot time.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

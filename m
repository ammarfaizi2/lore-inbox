Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264615AbSIQVT7>; Tue, 17 Sep 2002 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264618AbSIQVT7>; Tue, 17 Sep 2002 17:19:59 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:761 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264615AbSIQVT6>; Tue, 17 Sep 2002 17:19:58 -0400
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
In-Reply-To: <20020917.135451.49037528.davem@redhat.com>
References: <1032294559.22815.180.camel@cog.suse.lists.linux.kernel>
	<20020917.133933.69057655.davem@redhat.com.suse.lists.linux.kernel>
	<p73vg54tjpl.fsf@oldwotan.suse.de> 
	<20020917.135451.49037528.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Sep 2002 22:28:12 +0100
Message-Id: <1032298092.20498.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 21:54, David S. Miller wrote:
> The cpu gets a bus clock input, so the system tick should be processor
> local as much as TSC is.
> 
> It's boggling that this is being messed up so much.  I can't believe
> Sun got something incredibly right (Ultra-III has a system tick) :-)

A bus clock - but things like the x440 have more than one bus clock. Its
NUMA. Also the bus clock and rdtsc clock are different - rdtsc is
dependant on the multiplier. Shove a celeron 300 and a celeron 450 in a
BP6 board with tsc on and enjoy


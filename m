Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264569AbSIQU7I>; Tue, 17 Sep 2002 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264550AbSIQU7H>; Tue, 17 Sep 2002 16:59:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11395 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264569AbSIQU6w>;
	Tue, 17 Sep 2002 16:58:52 -0400
Date: Tue, 17 Sep 2002 13:54:51 -0700 (PDT)
Message-Id: <20020917.135451.49037528.davem@redhat.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73vg54tjpl.fsf@oldwotan.suse.de>
References: <1032294559.22815.180.camel@cog.suse.lists.linux.kernel>
	<20020917.133933.69057655.davem@redhat.com.suse.lists.linux.kernel>
	<p73vg54tjpl.fsf@oldwotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 17 Sep 2002 23:00:38 +0200
   
   Also reading HPET is somewhat more costly than reading TSCs because it
   goes to the southbridge, so there are cases where using TSC is
   probably better (e.g. I think for networking packet time stamping the
   TSC is just fine with all its limitations)

The cpu gets a bus clock input, so the system tick should be processor
local as much as TSC is.

It's boggling that this is being messed up so much.  I can't believe
Sun got something incredibly right (Ultra-III has a system tick) :-)

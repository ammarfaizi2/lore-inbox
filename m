Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRCULcH>; Wed, 21 Mar 2001 06:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCULb6>; Wed, 21 Mar 2001 06:31:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51584 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131341AbRCULbm>;
	Wed, 21 Mar 2001 06:31:42 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15032.37094.204955.41554@pizda.ninka.net>
Date: Wed, 21 Mar 2001 03:30:46 -0800 (PST)
To: george anzinger <george@mvista.com>
Cc: Keith Owens <kaos@ocs.com.au>, nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <3AB88929.D1B324F2@mvista.com>
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
	<22991.985166394@ocs3.ocs-net>
	<15032.30533.638717.696704@pizda.ninka.net>
	<3AB88929.D1B324F2@mvista.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


george anzinger writes:
 > By the by, if a preemption lock is all that is needed the patch defines
 > it and it is rather fast (an inc going in and a dec & test comming
 > out).  A lot faster than a spin lock with its "LOCK" access.  A preempt
 > lock does not need to be "LOCK"ed because the only contender is the same
 > cpu.

So we would have to invoke this thing around every set of
smp_processor_id() references?

Later,
David S. Miller
davem@redhat.com

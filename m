Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRCUJmx>; Wed, 21 Mar 2001 04:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRCUJmn>; Wed, 21 Mar 2001 04:42:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45696 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131508AbRCUJmg>;
	Wed, 21 Mar 2001 04:42:36 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15032.30533.638717.696704@pizda.ninka.net>
Date: Wed, 21 Mar 2001 01:41:25 -0800 (PST)
To: Keith Owens <kaos@ocs.com.au>
Cc: nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: <22991.985166394@ocs3.ocs-net>
In-Reply-To: <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org>
	<22991.985166394@ocs3.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > Or have I missed something?

Nope, it is a fundamental problem with such kernel pre-emption
schemes.  As a result, it would also break our big-reader locks
(see include/linux/brlock.h).

Basically, anything which uses smp_processor_id() would need to
be holding some lock so as to not get pre-empted.

Later,
David S. Miller
davem@redhat.com

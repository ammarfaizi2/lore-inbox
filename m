Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTIWTAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTIWTAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:00:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63451 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263406AbTIWTAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:00:43 -0400
Date: Tue, 23 Sep 2003 11:47:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923114744.137d5dac.davem@redhat.com>
In-Reply-To: <16240.36993.148535.613568@napali.hpl.hp.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
	<20030923105712.552dbb1e.davem@redhat.com>
	<16240.36993.148535.613568@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 11:27:13 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

>  - use the dmesg command to lower the printing threshold below KERN_WARNING
>    ("dmesg -n4", IIRC)

Not terribly useful if all the unaligned messages made the one I'm
interested in get kicked out of the logs.

>  - use prctl --unalign=silent to turn off unaligned printing for a
>    particular task and its children

What about for the kernel?

No other port is so obstinate about printing out unaligned kernel
access messages, why does ia64 have to be so different?

Unaligned accesses are not only perfectly fine in the kernel, they
are in fact expected in certain circumstances.

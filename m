Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266076AbUALKt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUALKt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:49:27 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:35248 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S266076AbUALKt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:49:26 -0500
Subject: Re: [Bug 1764] New: conntrack oops while reading
	/proc/net/ip_conntrack
From: Christophe Saout <christophe@saout.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       laforge@netfilter.org, netfilter-devel@lists.netfilter.org
In-Reply-To: <20040103152921.76d4362e.rusty@rustcorp.com.au>
References: <11020000.1072813876@[10.10.2.4]>
	 <20040103152921.76d4362e.rusty@rustcorp.com.au>
Content-Type: text/plain
Message-Id: <1073904557.7268.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 11:49:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa, den 03.01.2004 schrieb Rusty Russell um 05:29:

> > http://bugme.osdl.org/show_bug.cgi?id=1764
> > 
> >            Summary: conntrack oops while reading /proc/net/ip_conntrack
> >     Kernel Version: 2.6.0
> >             Status: NEW
> >           Severity: high
> >              Owner: laforge@gnumonks.org
> >          Submitter: christophe@saout.de
> ...
> > Apparently expect->expectant->helper is NULL in print_expect
> > (net/ipv4/netfilter/ip_conntrack_standalone.c).
> 
> Um, Harald, other developers,
> 
> 	Shouldn't list_conntracks do READ_LOCK(&ip_conntrack_expect_tuple_lock) before walking the expect list?
> 
> Here's a patch.  Does it do anything?

The problem seems to fixed. The machine was stable the last week, before
it crashed at least once a day.

thanks.



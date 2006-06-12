Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752077AbWFLQVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbWFLQVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWFLQVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:21:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32424 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752077AbWFLQVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:21:07 -0400
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <448D922F.80801@microgate.com>
References: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
	 <1150124830.3703.6.camel@amdx2.microgate.com>
	 <1150127588.25462.7.camel@localhost.localdomain>
	 <448D922F.80801@microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 17:36:45 +0100
Message-Id: <1150130206.25462.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-12 am 11:11 -0500, ysgrifennodd Paul Fulghum:
> If a driver has low_latency set, flush_to_ldisc
> can be called from both scheduled work (due to
> hitting TTY_DONT_FLIP) and directly from an ISR.
> On an SMP system, they can run in parallel.

Ok, so yet another reason that the ugly TTY_DONT_FLIP hack should die
forever.

Alan


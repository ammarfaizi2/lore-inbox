Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTIWS6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTIWS6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:58:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57307 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263384AbTIWS6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:58:04 -0400
Date: Tue, 23 Sep 2003 11:45:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: tony.luck@intel.com, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       peter@chubb.wattle.id.au, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923114504.2d46054f.davem@redhat.com>
In-Reply-To: <20030923142925.A16490@kvack.org>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 14:29:25 -0400
Benjamin LaHaise <bcrl@kvack.org> wrote:

> On Tue, Sep 23, 2003 at 11:21:35AM -0700, Luck, Tony wrote:
> > Looking at a couple of ia64 build servers here I see zero unaligned
> > access messages in the logs.
> 
> ip options can still be an odd number of bytes.  Having itanic spew bogus 
> log messages is just plain wrong (yet another hardware issue pushed off on 
> software for no significant gain).

Also, some TCP implementations sometimes don't align the timestamp
options in the headers as well.

Also, as I mentioned, try IP over appletalk.

Unaligned accesses are perfectly normal, _especially_ in the kernel.
This is an axiom of the kernel networking decided a long time ago, and
printing out a silly message when it happens doesn't make that any
less true.

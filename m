Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266072AbUF2VXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266072AbUF2VXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUF2VXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:23:17 -0400
Received: from mail.enyo.de ([212.9.189.167]:12551 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266072AbUF2VXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:23:02 -0400
To: Valdis.Kletnieks@vt.edu
Cc: Willy Tarreau <willy@w.ods.org>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
References: <40DC9B00@webster.usu.edu>
	<20040625150532.1a6d6e60.davem@redhat.com>
	<cbp62t$a38$1@news.cistron.nl>
	<20040628183709.GL29808@alpha.home.local>
	<87vfhbjxgw.fsf@deneb.enyo.de>
	<200406292003.i5TK3Y6o017275@turing-police.cc.vt.edu>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 29 Jun 2004 23:22:56 +0200
In-Reply-To: <200406292003.i5TK3Y6o017275@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Tue, 29 Jun 2004 16:03:34 -0400")
Message-ID: <87brj212kv.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis Kletnieks:

> The latest numbers I saw on the NANOG list estimated that only 30%
> to 40% of core peerings were using MD5 even several weeks after the
> Great MD5-Fest...

30% to 40% is extremely high.  Are you sure these numbers are correct?

> I am told that at least some versions of IOS got it Very Very Wrong
> - rather than first checking the simple things like "is the
> source/dest addr/ports/seq on the RST in bounds?" or "is a BGP
> packet?", it would check the MD5 *first* - meaning you could swamp
> the real CPU by sending it a totally bogus stream of allegedly
> MD5-signed traffic..

I think the MD5 option is designed to be processed *before* semantic
analysis of the TCP header.  This way, it will protect the router in
case of TCP header parsing bugs.  So it's not "Very Very Wrong", just
a different trade-off.

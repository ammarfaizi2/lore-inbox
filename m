Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWKPJj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWKPJj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWKPJj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:39:56 -0500
Received: from [80.71.248.82] ([80.71.248.82]:47821 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1422777AbWKPJjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:39:54 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, Hugh Dickins <hugh@veritas.com>,
       Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114184919.GA16020@skynet.ie>
	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	<20061114113120.d4c22b02.akpm@osdl.org>
	<Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	<20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	<20061115232228.afaf42f2.akpm@osdl.org>
	<1163666960.4310.40.camel@localhost.localdomain>
	<20061116011351.1401a00f.akpm@osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: CFS
Date: Thu, 16 Nov 2006 12:37:17 +0300
In-Reply-To: <20061116011351.1401a00f.akpm@osdl.org> (Andrew Morton's message of "Thu, 16 Nov 2006 01:13:51 -0800")
Message-ID: <m3hcwzhgvm.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> What lock protects the fields in struct ext[234]_reserve_window from being
 AM> concurrently modified by two CPUs?  None, it seems.  Ditto
 AM> ext[234]_reserve_window_node.  i_mutex will cover it for write(), but not
 AM> for pageout over a file hole.  If we end up with a zero- or negative-sized
 AM> window then odd things might happen.

truncate_mutex?

thanks, Alex


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbULXRC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbULXRC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULXRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:02:27 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:62427
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261327AbULXRCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:02:24 -0500
Date: Fri, 24 Dec 2004 09:02:10 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: clameter@sgi.com, akpm@osdl.org, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [2/4]: add second parameter to clear_page() for
 all arches
Message-Id: <20041224090210.4bbe11a8.davem@davemloft.net>
In-Reply-To: <20041224162745.GA1178@elf.ucw.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
	<20041224083337.GA1043@openzaurus.ucw.cz>
	<Pine.LNX.4.58.0412240818030.6505@schroedinger.engr.sgi.com>
	<20041224162745.GA1178@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 17:27:45 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> I do not know what Andi said, but having clear_page clearing two
> page*s* seems wrong to me.

It's represented by a single top-level page struct regardless
of it's order, so in that sense it's indeed a single page
no matter it's order.

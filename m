Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWEBUH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWEBUH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWEBUH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:07:26 -0400
Received: from xenotime.net ([66.160.160.81]:47284 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751279AbWEBUHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:07:25 -0400
Date: Tue, 2 May 2006 13:09:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linux-sparse@vger.kernel.org
Cc: xavier.bestel@free.fr, davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: C++ pushback + sparse
Message-Id: <20060502130950.61792c71.rdunlap@xenotime.net>
In-Reply-To: <20060426134419.a0515561.rdunlap@xenotime.net>
References: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
	<1146082192.11123.4.camel@bip.parateam.prv>
	<20060426134419.a0515561.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 13:44:19 -0700 Randy.Dunlap wrote:

> > > 	C++ has how many additional reserved words? I believe the list is delete,
> > > friend, private, protected, public, template, throw, try, and catch.
> > 
> > You forgot namespace, mutable, new, class, const_cast, dynamic_cast,
> > static_cast, reinterpret_cast, explicit, true, false, operator, typeid,
> > typename and virtual. Maybe I forgot some (interface ?). Probably some
> > new ones will appear.
> 
> I did a sparse patch to check for all(?) of those once (with Linus's
> help).  I don't know if it still applies or not...
> 
> It's at http://www.xenotime.net/linux/sparse/check_keywords_v7.patch
> (You'll also need the other patch there; they got a bit comingled:
> http://www.xenotime.net/linux/sparse/check_sizeof_v7.patch)

I updated this patch so that it works with sparse (snapshot of
2006-may-01).  The patch is here:
http://www.xenotime.net/linux/sparse/sparse-keywords-sizes.patch


sparse additions to:
- check for C/C++ keywords: usage: -keywords
- print all global data symbols and their sizes: usage: -list-symbols
  Example of -list-symbols:
  make C=2 CF="-list-symbols" arch/x86_64/kernel/smpboot.o
  arch/x86_64/kernel/smpboot.c:90:20: struct cpuinfo_x86 [addressable] [toplevel
] [assigned] cpu_data[8]: compound size 1344, alignment 64

---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUIBV6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUIBV6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269180AbUIBV6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:58:07 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:7766 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269196AbUIBV4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:56:00 -0400
Date: Thu, 2 Sep 2004 14:55:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: benh@kernel.crashing.org, akpm@osdl.org, clameter@sgi.com,
       paulus@samba.org, ak@muc.de, ak@suse.de, wli@holomorphy.com,
       davem@redhat.com, raybry@sgi.com, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040902145500.271ae676.davem@davemloft.net>
In-Reply-To: <20040902212634.GJ16175@wotan.suse.de>
References: <20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040828010253.GA50329@muc.de>
	<20040827183940.33b38bc2.akpm@osdl.org>
	<16687.59671.869708.795999@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
	<20040827204241.25da512b.akpm@osdl.org>
	<Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
	<20040827223954.7d021aac.akpm@osdl.org>
	<1094012028.6539.320.camel@gaston>
	<20040902212634.GJ16175@wotan.suse.de>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004 23:26:34 +0200
Andi Kleen <ak@suse.de> wrote:

> I would do atomic64 on 64bit archs only and then do a wrapper 
> somewhere that defines atomiclongt based on BITSPERLONG 

We do have CONFIG_64BIT, might as well use it.

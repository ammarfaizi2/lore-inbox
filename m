Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTJRBl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 21:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTJRBl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 21:41:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:48023 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261294AbTJRBl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 21:41:27 -0400
Date: Fri, 17 Oct 2003 18:41:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Chapman <matthewc@cse.unsw.edu.au>
Cc: davidm@hpl.hp.com, bjorn.helgaas@hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] prevent "dd if=/dev/mem" crash
Message-Id: <20031017184111.22eaa13d.akpm@osdl.org>
In-Reply-To: <20031018013137.GA16845@cse.unsw.EDU.AU>
References: <200310171610.36569.bjorn.helgaas@hp.com>
	<20031017155028.2e98b307.akpm@osdl.org>
	<200310171725.10883.bjorn.helgaas@hp.com>
	<20031017165543.2f7e9d49.akpm@osdl.org>
	<16272.34681.443232.246020@napali.hpl.hp.com>
	<20031017174955.6c710949.akpm@osdl.org>
	<20031018013137.GA16845@cse.unsw.EDU.AU>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Chapman <matthewc@cse.unsw.edu.au> wrote:
>
> It *does* signal a fault, in the form of a machine check.  On other
>  architectures I'm familiar with this is usually implemented as an
>  interrupt, but the idea is similar - when the system bus controller
>  detects a bad address on the bus, it returns all 1s (for a read) and
>  signals an interrupt.

I see.  That seems OK.  At least it means that software can implement a
probing function and that the time interval between hot unplug and handling
the unplug interrupt can be managed appropriately.



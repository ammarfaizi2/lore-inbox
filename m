Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUAWHna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUAWHna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:43:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:51418 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266536AbUAWHn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:43:29 -0500
Subject: Re: swsusp vs  pgdir
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123073426.GA211@elf.ucw.cz>
References: <1074833921.975.197.camel@gaston>
	 <20040123073426.GA211@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1074843781.878.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 18:43:18 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We test that CPU has PSE feature. That means kernel is mapped using
> 4MB page tables, and I do not have to care about page tables at
> all.

Just enlighten me please: How do these 4Mb page tables work ? The pgdir
entries contain special bits ? Then you at least must make sure the
swapper_pgdir is left intact. This is the case ? (I also suppose you
mean the entire linear mapping, not just the kernel, is mapped with
4M pages)

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270244AbTGRRoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270262AbTGRRoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:44:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:63369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270244AbTGRRoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:44:13 -0400
Date: Fri, 18 Jul 2003 11:02:58 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend testing in 2.6.0-test1
In-Reply-To: <20030718175045.GA195@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307181101110.22018-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I wanted to avoid that: we do want user threads refrigerated at that
> point so that we know noone is allocating memory as we are trying to
> do memory shrink. I'd like to avoid having refrigerator run in two
> phases....

But we should be the only process running, and we can guarantee that by 
not sleeping and doing preempt_disable() when we begin. Especially 
if we start the refrigeration sequence after we shrink memory. Right? 


	-pat


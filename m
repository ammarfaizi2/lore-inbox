Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUCDFoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbUCDFoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:44:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:20354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261461AbUCDFoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:44:20 -0500
Date: Wed, 3 Mar 2004 21:44:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: ak@suse.de, george@mvista.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040303214410.1ba0ab9d.akpm@osdl.org>
In-Reply-To: <200403041059.43439.amitkale@emsyssoft.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<200403041036.58827.amitkale@emsyssoft.com>
	<20040303211850.05d44b4a.akpm@osdl.org>
	<200403041059.43439.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> To a user it'll appear as a 
>  message printed from gdb "Page fault at 0x1234" followed by gdb showing a 
>  SIGSEGV etc.

Well that would be nice.  Bear in mind that one usage scenario is to say
"hey, machine 342 has stopped responding" and to then fire up gdb and
connect to that machine with kgdboe.

In other words: if we rely on a gdb instance being connected at the time of
the exception, that message will be lost.  There needs to be a way of
retrieving the message post-facto.


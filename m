Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUCDFTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUCDFTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:19:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:3809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261455AbUCDFTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:19:05 -0500
Date: Wed, 3 Mar 2004 21:18:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: ak@suse.de, george@mvista.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       piggy@timesys.com, trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-Id: <20040303211850.05d44b4a.akpm@osdl.org>
In-Reply-To: <200403041036.58827.amitkale@emsyssoft.com>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>
	<40467BC3.7030708@mvista.com>
	<20040304015056.4d2cc3ee.ak@suse.de>
	<200403041036.58827.amitkale@emsyssoft.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit S. Kale" <amitkale@emsyssoft.com> wrote:
>
> Flashing keyboard lights is easy on x86 and x86_64 platforms. 

Please, no keyboards.  Some people want to be able to use kgdboe
to find out why machine number 324 down the corridor just died.

How about just doing


char *why_i_crashed;


{
	...
	if (expr1)
		why_i_crashed = "hit a BUG";
	else if (expr2)
		why_i_crashed = "divide by zero";
	else ...
}

then provide a gdb macro which prints out the string at *why_i_crashed?


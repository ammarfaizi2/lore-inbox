Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbTCQS7I>; Mon, 17 Mar 2003 13:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbTCQS7H>; Mon, 17 Mar 2003 13:59:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18406 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261837AbTCQS7H>;
	Mon, 17 Mar 2003 13:59:07 -0500
Date: Mon, 17 Mar 2003 11:06:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "dave" <davekern@ihug.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error using unsigned long long not working in 2.4.x
Message-Id: <20030317110658.5aff6ebc.rddunlap@osdl.org>
In-Reply-To: <002d01c2ed11$6ba7a110$0b721cac@stacy>
References: <002d01c2ed11$6ba7a110$0b721cac@stacy>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 21:44:16 -0800 "dave" <davekern@ihug.co.nz> wrote:

| hi i am writing a kernel 2.4.x driver and need to do maths on 64 bit ints
| (unsigned long long)
| bcause you can not use the FPU
| but when i insmod i get the error unresolved symbol __udivdi3 i need!! 64
| bit ints

Other alternatives are search the lkml archive for a patch from
George Anzinger on 2003-mar-05,
subject: [PATCH] Functions to do easy scaled math.

or if all you need is 64-bit mul and div, and only during setup
(when speed isn't a huge factor), you could use the divrem64()
function in this sample /procfs module:
  http://www.xenotime.net/linux/procfs_ex/procdiv64.c

--
~Randy

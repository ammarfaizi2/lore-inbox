Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTCPBUS>; Sat, 15 Mar 2003 20:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbTCPBUS>; Sat, 15 Mar 2003 20:20:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9670 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261908AbTCPBUP>; Sat, 15 Mar 2003 20:20:15 -0500
Date: Sat, 15 Mar 2003 20:31:03 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200303160131.h2G1V3B10636@devserv.devel.redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: bitmaps/bitops
In-Reply-To: <mailman.1047762781.3457.linux-kernel2news@redhat.com>
References: <mailman.1047762781.3457.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but the prototype for test_and_set_bit() depends on $(ARCH), and it's
> not consistent, with the second arg (bitmap address) being one of:
>   volatile void *
>   void *
>   volatile unsigned long *

It should be unsigned long pointer. I have no idea why
volatile is still alive. Perhaps Linus can remember why he
left it in on is386. Other arch maintainers midnlessly ape him
in this area. I think I even kept his e-mail where he explains
why volatile has to go.

-- Pete

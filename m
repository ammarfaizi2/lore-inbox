Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268803AbRG0Jqu>; Fri, 27 Jul 2001 05:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268804AbRG0Jqk>; Fri, 27 Jul 2001 05:46:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57605 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268803AbRG0JqZ>; Fri, 27 Jul 2001 05:46:25 -0400
Subject: Re: Validating Pointers
To: tpepper@vato.org
Date: Fri, 27 Jul 2001 10:47:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010726201909.A19877@cb.vato.org> from "tpepper@vato.org" at Jul 26, 2001 08:19:09 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q4DE-0005KT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> 	copy_to_user(user_addr, kernel_addr, size);
> 		and
> 	copy_from_user(kernel_addr, user_addr, size);
> 
> Are you saying that static and dynamically allocated kernel variables end up
> in different segments (kernel_ds and user_ds) and the copy is only expected to
> succeed if the to and from addresses are in the same segment?

user and kernel address spaces are seperate. On S/390 and M68K for example
they occupy the same values for both. Long long ago this was done via
segments on x86 (we dont use segments now) and thus the functions to do 
what you want are still called set_fs/get_fs/get_ds

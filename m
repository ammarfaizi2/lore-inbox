Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274076AbRI0XOD>; Thu, 27 Sep 2001 19:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274075AbRI0XNx>; Thu, 27 Sep 2001 19:13:53 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:63182 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S274072AbRI0XNh>;
	Thu, 27 Sep 2001 19:13:37 -0400
Date: Fri, 28 Sep 2001 01:13:50 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109272313.BAA16620@harpo.it.uu.se>
To: bgerst@didntduck.org
Subject: Re: [PATCH] Cleanup f00f bug code
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 21:52:09 -0400, Brian Gerst wrote:

>This patch changes the f00f bug workaround code to use a fixed mapping
>instead of touching the page tables directly.  It also removes the
>assumption that only 686's don't have the bug.  It has been tested for
>normal operation of the relocated IDT, but I don't have a processor with
>the bug to do a real test.  Could someone with such a processor please
>verify that the workaround still works?

It doesn't. 2.4.9-ac16 + your patch booted ok on my P5MMX, and the
kernel printed that it applied the F0 0F workaround, but executing
F0 0F C7 C8 in user-space caused an instant lockup.

/Mikael

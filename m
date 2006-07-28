Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWG1VbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWG1VbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWG1VbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:31:15 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:64968 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1161312AbWG1VbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:31:15 -0400
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
From: Nicholas Miell <nmiell@comcast.net>
To: Lars Noschinski <cebewee@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ricknu-0@student.ltu.se,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <20060728202401.GA24439@lars.home.noschinski.de>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <1153945705.44c7d069c5e18@portal.student.luth.se>
	 <200607270448.03257.arnd.bergmann@de.ibm.com>
	 <1153978047.2807.5.camel@entropy>
	 <1154030149.44c91a453d6b0@portal.student.luth.se>
	 <1154091022.13509.112.camel@localhost.localdomain>
	 <20060728202401.GA24439@lars.home.noschinski.de>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 14:31:11 -0700
Message-Id: <1154122271.2451.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 22:24 +0200, Lars Noschinski wrote:
> * Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-07-28 22:14]:
> >Ar Iau, 2006-07-27 am 13:13 -0700, ysgrifennodd Nicholas Miell:
> >> The compiler knows that "b = !!b;" is a no-op.
> >
> >b = !!b isn't a no-op.
> 
> For _Bool it should be:
> 
> >Try printf("%d", !!4);
> 
> printf("%d, %d", (_Bool)4, !!(_Bool)4);
> 
> prints "1, 1". From ISO/IEC 9899:1999:
> 
> When any scalar value is converted to _Bool, the result is 0 if the
> value compares equal to 0; otherwise, the result is 1.
> 

We're not talking about scalar values converted to _Bool, we're talking
about the kernel getting a supposed _Bool from userspace which doesn't
actually contain 0 or 1. (i.e. as far as the kernel and/or gcc is
concerned, the scalar conversion has already taken place)

-- 
Nicholas Miell <nmiell@comcast.net>


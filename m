Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWG1UX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWG1UX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWG1UX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:23:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:24964 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1161279AbWG1UX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:23:57 -0400
Date: Fri, 28 Jul 2006 22:24:01 +0200
From: Lars Noschinski <cebewee@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nicholas Miell <nmiell@comcast.net>, ricknu-0@student.ltu.se,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Message-ID: <20060728202401.GA24439@lars.home.noschinski.de>
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153945705.44c7d069c5e18@portal.student.luth.se> <200607270448.03257.arnd.bergmann@de.ibm.com> <1153978047.2807.5.camel@entropy> <1154030149.44c91a453d6b0@portal.student.luth.se> <1154091022.13509.112.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1154091022.13509.112.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-07-28 22:14]:
>Ar Iau, 2006-07-27 am 13:13 -0700, ysgrifennodd Nicholas Miell:
>> The compiler knows that "b = !!b;" is a no-op.
>
>b = !!b isn't a no-op.

For _Bool it should be:

>Try printf("%d", !!4);

printf("%d, %d", (_Bool)4, !!(_Bool)4);

prints "1, 1". From ISO/IEC 9899:1999:

When any scalar value is converted to _Bool, the result is 0 if the
value compares equal to 0; otherwise, the result is 1.


Greetings,
     Lars

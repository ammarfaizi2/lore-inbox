Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWGBRbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGBRbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGBRbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:31:45 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45791 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751285AbWGBRbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:31:45 -0400
Date: Sun, 02 Jul 2006 11:31:42 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:
 undefined reference to `__stack_chk_fail'
In-reply-to: <fa.iffnN5wM1UwqtCYhmqLAkGCMC2o@ifi.uio.no>
To: Miles Lane <miles.lane@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Message-id: <44A802FE.2020203@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.iPhEst5K48JbrGWRr3l3/GEBesY@ifi.uio.no>
 <fa.iffnN5wM1UwqtCYhmqLAkGCMC2o@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> Well, from the web page referenced at the top of this message, you
> can see that they are already aware of these issues:
> 
> Cons:
>    *      It breaks current upstream kernel builds and potentially
> other direct usages of gcc. Kernel is by far the most important use
> case. Upstream should change the default options to build with
> -fno-stack-protector by default.
>    *      It is not conformant to upstream gcc behaviour.

I don't see why the kernel should have to insert compile flags to 
counteract any random non-default compile flags that the system may 
decide to insert. I think the way Ubuntu has done this is broken, they 
are essentially changing the default settings on the compiler in a way 
which breaks the kernel due to needing external libraries.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


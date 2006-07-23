Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWGWPny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWGWPny (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 11:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGWPny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 11:43:54 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:2013 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S1751228AbWGWPnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 11:43:52 -0400
Message-ID: <1153669426.44c39932c2156@portal.student.luth.se>
Date: Sun, 23 Jul 2006 17:43:46 +0200
From: ricknu-0@student.ltu.se
To: =?ISO-8859-1?B?TGFycyBHdWxsaWsgQmr4bm5lcw==?= <larsbj@gullik.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153524422.44c162c65c21b@portal.student.luth.se> <m3mzb2c6bt.fsf@tyfon.gullik.net>
In-Reply-To: <m3mzb2c6bt.fsf@tyfon.gullik.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Lars Gullik Bjønnes <larsbj@gullik.net>:

> ricknu-0@student.ltu.se writes:
> 
> | --- a/include/asm-i386/types.h
> | +++ b/include/asm-i386/types.h
> | @@ -1,6 +1,13 @@
> |  #ifndef _I386_TYPES_H
> |  #define _I386_TYPES_H
> |  
> | +#if __GNUC__ >= 3
> | +typedef _Bool bool;
> | +#else
> | +#warning You compiler doesn't seem to support boolean types, will set
> 'bool' as
> | an 'unsigned int'
> | +typedef unsigned int bool;
> | +#endif
> | +
> 
> What does C99 say about sizeof(_Bool)?
> 
> At least with gcc 4 it is 1. Can that pose a problem? gcc < 3 giving a
> different size for bool?

Well, it might. I don't see it other then when someone uses a variable of
another type and the "boolean" variable (now an int) is of a larger value then
that variable. But then that is a bug and should be fixed.

But rest easy, bool will only be _Bool from now on. :)

> -- 
> 	Lgb

Richard Knutsson


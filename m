Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTFLMi6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbTFLMi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:38:58 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:36105 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S264632AbTFLMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:38:57 -0400
Message-Id: <200306121252.h5CCqTt10677@pincoya.inf.utfsm.cl>
To: Steve French <smfrench@austin.rr.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       vonbrand@inf.utfsm.cl
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3 
In-reply-to: Your message of "Wed, 11 Jun 2003 20:24:41 EST."
             <3EE7D659.2000003@austin.rr.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Thu, 12 Jun 2003 08:52:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> said:
> Although it fixes it for building on 32 bit architectures, won't changing
> 
> 
> 	__u64 uid = 0xFFFFFFFFFFFFFFFF;
> to
> 
> 	__u64 uid = 0xFFFFFFFFFFFFFFFFULL;
> 
> generate a type mismatch warning on ppc64 and similar 64 bit
> architecutres since __u64 is not a unsigned long long on ppc64 
> (it is unsigned long)?  My gut reaction is to just ingore the three
> places that cause warnings and the remaining two places that cause 
> signed/unsigned compare warnings of unsigned int local variables 
> to #defined literals (which presumably are treated as signed by default).

Be careful, the value will get shoehorned into 4 bytes to make the int
constant, which is then assigned to the __u64.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

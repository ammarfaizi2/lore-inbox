Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261918AbREREpf>; Fri, 18 May 2001 00:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262002AbREREpZ>; Fri, 18 May 2001 00:45:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:64016 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261918AbREREpF>;
	Fri, 18 May 2001 00:45:05 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105180444.f4I4ivs515318@saturn.cs.uml.edu>
Subject: Re: [PATCH] 2.4.5pre3 warning fixes
To: Sam.Bingner@hickam.af.mil (Bingner Sam J. Contractor RSIS)
Date: Fri, 18 May 2001 00:44:57 -0400 (EDT)
Cc: richbaum@acm.org, linux-kernel@vger.kernel.org
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F697326@FSKNMD07.hickam.af.mil> from "Bingner Sam J. Contractor RSIS" at May 17, 2001 07:49:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bingner Sam J. Con writes:

> Looks to me like it's adding { and } on each side of the
> "c->devices->prev=d;" statement... so changing from:
> 
> if (c->devices != NULL)
> 	c->devices->prev=d;
> 
> to 
> 
> if (c->devices != NULL){
> 	c->devices->prev=d;
> }
> 
> I assume the new compiler likes the if to have explicit
> brackets instead of using the next statement...

Maybe one of these will make it happy:

(void)(c->devices && (c->devices->prev=d));

!c->devices ?: (c->devices->prev=d);

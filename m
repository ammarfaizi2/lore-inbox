Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbRCHAyl>; Wed, 7 Mar 2001 19:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbRCHAyV>; Wed, 7 Mar 2001 19:54:21 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:34569 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131253AbRCHAyP>; Wed, 7 Mar 2001 19:54:15 -0500
Message-Id: <200103080053.f280rpO33821@aslan.scsiguy.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx funcs without return values 
In-Reply-To: Your message of "Thu, 08 Mar 2001 01:21:49 +0100."
             <20010308012149.A1158@werewolf.able.es> 
Date: Wed, 07 Mar 2001 17:53:51 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>Just a note to make gcc 2.96 (and future) happy. The aic7xxx driver is full of
>inline funcs that should return a value and do not do that:

They don't return a value because doing so is meaningless.  You aren't
going to get past the panic.  The compiler should know that assuming
panic is properly tagged as a function that cannot return.

You may also want to check up on your C since having a break after
a return is, well, kinda silly.  In all the usage of this inline, the
width is constant, so gcc should completely optimize away the switch
and surrounding code.

--
Justin

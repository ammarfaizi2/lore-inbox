Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288999AbSAITzE>; Wed, 9 Jan 2002 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288998AbSAITzB>; Wed, 9 Jan 2002 14:55:01 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:24019 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S288991AbSAITyX>;
	Wed, 9 Jan 2002 14:54:23 -0500
From: mike stump <mrs@windriver.com>
Date: Wed, 9 Jan 2002 11:53:37 -0800 (PST)
Message-Id: <200201091953.LAA27042@kankakee.wrs.com>
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: dewar@gnat.com
> To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
> Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
>         velco@fadata.bg
> Date: Tue,  8 Jan 2002 21:13:43 -0500 (EST)

> Yes, of course! No one disagrees. I am talking about *LOADS* not
> stores, your example is 100% irrelevant to my point, since it does
> stores.

Ok, in the bodies of those, put in

j1=c1;

j2=c2;

j3=c3;

With new definitions for j1, j2 and k3 as being volatile.  Accesses are volatile:

       [#2] Accessing  a  volatile  object,  modifying  an  object,
       modifying  a  file,  or  calling a function that does any of
       those operations are all side effects

So, I would claim that the case is symetric with writing volatiles.
If the standard doesn't make a distinction for write v read, then you
can't and claim that distinction is based in the standard.  If you
claim the standard does make a distinction, please point it out, I am
unaware of it.

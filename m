Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312380AbSDJBwj>; Tue, 9 Apr 2002 21:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312386AbSDJBwi>; Tue, 9 Apr 2002 21:52:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20489 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312380AbSDJBwh>; Tue, 9 Apr 2002 21:52:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: C++ and the kernel
Date: 9 Apr 2002 18:52:19 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a905sj$dl7$1@cesium.transmeta.com>
In-Reply-To: <20020409122622.GN612@gallifrey> <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> > 
> > Bollox!
> > 
> > There are many places in the kernel that are actually very OO - look at
> > filesystems for example. The super_operations sturcture is in effect a
> > virtual function table.
> 
> The file operations structure(s) are structures. They are not object-
> oriented in any way, and they are certainly not virtual. The code that
> manipulates them is quite physical and procedural, well defined, and
> visible to the rest of the kernel.
> 

Again, bollocks.  The file operation structures are vanilla vtbl
implementations of virtual functions.  The fact that they're written

foo->f_ops->func(foo, ...);

instead of

foo->func(...);

makes absolutely no difference whatsoever.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

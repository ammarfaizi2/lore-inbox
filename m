Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbTBGVth>; Fri, 7 Feb 2003 16:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbTBGVth>; Fri, 7 Feb 2003 16:49:37 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:25525 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S266730AbTBGVtf>;
	Fri, 7 Feb 2003 16:49:35 -0500
Date: Fri, 7 Feb 2003 22:58:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: root@chaos.analogic.com
Cc: John Bradford <john@grabjohn.com>, Russell King <rmk@arm.linux.org.uk>,
       fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
Message-ID: <20030207215817.GA2092@werewolf.able.es>
References: <Pine.LNX.3.95.1030207152853.31273A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.95.1030207152853.31273A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Feb 07, 2003 at 21:47:28 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.07 Richard B. Johnson wrote:
> On Fri, 7 Feb 2003, John Bradford wrote:
> 
[...]
> 
>    for (new2size = 128; new2size < newsize; new2size <<= 1)
>        ;
> 
> The code seems to want to make the value of new2size a power of
> 2 and, greater than 128, but less than newsize. It ignores the
> fact that newsize might be less than 128, maybe this is okay.
> But, the code goes on, eventually settling on new2size being
> less than 4096... hmmm. I'll bet this could be greatly
> simplified. I think 'new2size' is really something that will
> fit inside 128-byte groups. Maybe an & or a % will greatly
> simplify?
> 

Isn't just a ffs or the like ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))

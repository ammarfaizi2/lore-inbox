Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269392AbRHQBhn>; Thu, 16 Aug 2001 21:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269404AbRHQBhd>; Thu, 16 Aug 2001 21:37:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50950 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S269392AbRHQBhP>;
	Thu, 16 Aug 2001 21:37:15 -0400
Message-ID: <3B7C7235.1E09C034@linux-m68k.org>
Date: Fri, 17 Aug 2001 03:24:05 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <20010816144109.A5094@cb.vato.org>
		<20010816.153151.74749641.davem@redhat.com>
		<5.1.0.14.2.20010816234350.00add710@pop.cus.cam.ac.uk> <20010816.163852.115909286.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

>    IMHO, it would have been more elegant to use the typeof construct provided
>    by gcc in the new macro instead of introducing a type parameter like this...
> 
> The whole point was to make users explicitly state the type so they
> would have to think about it.

I have two problems with this:
1. They maybe think once about it, but are they doing it a second time?
If the type of the argument is changed somewhere in the header, the min
argument is easily missed, since...
2. This macro doesn't produce a warning like the typeof version does.
The typeof version warns you about signed/unsigned compares, while an
assignment gives no warning.

bye, Roman

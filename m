Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317826AbSFSJSi>; Wed, 19 Jun 2002 05:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317828AbSFSJSh>; Wed, 19 Jun 2002 05:18:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:59622 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317826AbSFSJSg>; Wed, 19 Jun 2002 05:18:36 -0400
Date: Wed, 19 Jun 2002 11:18:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Manik Raina <manik@cisco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: (off 2.5.22) replacing __builtin_expect with unlikely
 in Alpha headers 
In-Reply-To: <3D104A50.24C00206@cisco.com>
Message-ID: <Pine.NEB.4.44.0206191117190.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Manik Raina wrote:

>
>     This fix should remove __builtin_expect () and replace it with
> unlikely ()  in include/asm-alpha/rwsem.h
>     This should be cool since rwsem.h already includes
> include/linux/compiler.h
>
>     Files changed :
>
>     include/asm-alpha/rwsem.h

The following part of your patch is obviously a typo:

-       if (__builtin_expect(count, 0))
+       if (unlikely(count, 0))
                          ^^^

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSJIRQe>; Wed, 9 Oct 2002 13:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbSJIRQe>; Wed, 9 Oct 2002 13:16:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9232 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261863AbSJIRQd>; Wed, 9 Oct 2002 13:16:33 -0400
Date: Wed, 9 Oct 2002 10:24:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
In-Reply-To: <200210091432.15883.schwidefsky@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0210091022050.7355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Martin Schwidefsky wrote:
>
> Use common code for 16 bit user/groud id system calls on s390x.

Please make this use the real CONFIG_UID16_SYSCALLS instead of using a 
magic __UID16 thing that is s390x-specific. Then you make everybody who 
currently uses CONFIG_UID16 do both CONFIG_UID16 and 
CONFIG_UID16_SYSCALLS.

We don't want magic config options like __UID16 that aren't exposed as 
config options and make people go "Huh?!".

		Linus


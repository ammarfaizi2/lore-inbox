Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318416AbSGaRh7>; Wed, 31 Jul 2002 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318417AbSGaRh7>; Wed, 31 Jul 2002 13:37:59 -0400
Received: from www.transvirtual.com ([206.14.214.140]:43277 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318416AbSGaRh6>; Wed, 31 Jul 2002 13:37:58 -0400
Date: Wed, 31 Jul 2002 10:41:16 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Nico Schottelius <nico-mutt@schottelius.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUGS] 2.5.29: scsi/pcmcia|sound/trident|devfs
In-Reply-To: <20020731171517.GA818@schottelius.org>
Message-ID: <Pine.LNX.4.44.0207311037570.13905-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ################################################################################
> ### Hangup/Kernel Panics:
> ################################################################################
>
>    - devfs: drivers/char/console.c:2527: con_init_devfs(); is missing.
>      Hey guys, this bug exists in at least 3 kernel versions!

I'm working on a proper fix. BTW how do you get a kernel panic? I'm
running devfs plus con_init_devfs is not called. tty_register_devfs is
called by tty_register_driver. It is a issue of different flags being
passed to devfs by either tty functions. As soon a linus gives me a answer
to the problem I will post a patch for people to try and then push it to
BK.



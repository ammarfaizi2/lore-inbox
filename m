Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSGFRvZ>; Sat, 6 Jul 2002 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSGFRvY>; Sat, 6 Jul 2002 13:51:24 -0400
Received: from www.transvirtual.com ([206.14.214.140]:13578 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315708AbSGFRvW>; Sat, 6 Jul 2002 13:51:22 -0400
Date: Sat, 6 Jul 2002 10:53:55 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.25 dead kbd and gpm oops (my config error ?)
In-Reply-To: <3D26D705.9000808@oracle.com>
Message-ID: <Pine.LNX.4.44.0207061050050.26054-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> then the irq1
>   problem from i8042.c, the hotplug message from input.c and the
>   gpm oops(). This latter perhaps I should point to /dev/input/mouse
>   (/dev/mouse is a softlink to /dev/psaux) ?

Correct. You need to have /dev/mouse point to /dev/input/mice. This will
fix the gpm problem. Same with the X server. Note the irq1 stuff is
because pc_keyb.c is always compiled in. Its the same reason why people
with just USB keyboards get the AT keybaord not present error? GIve us
some time as the console system will migrate over to the input api.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288866AbSAEQoa>; Sat, 5 Jan 2002 11:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288865AbSAEQoV>; Sat, 5 Jan 2002 11:44:21 -0500
Received: from www.transvirtual.com ([206.14.214.140]:2835 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S288866AbSAEQoL>; Sat, 5 Jan 2002 11:44:11 -0500
Date: Sat, 5 Jan 2002 08:44:07 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: "Gabor Z. Papp" <gzp@myhost.mynet>
cc: linux-kernel@vger.kernel.org
Subject: Re: X and console paralell
In-Reply-To: <20020105080009.GI22314@gzp2.gzp>
Message-ID: <Pine.LNX.4.10.10201050839540.32301-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Gabor Z. Papp wrote:

> * Mark Vojkovich <mvojkovich@nvidia.com>:
> 
> | > Plugging extra USB keyboard and mouse would solve the
> | > problem, and I would be able to run X and console
> | > simultanously?
> | 
> |    No, both the console and X need a VT.  As far as I can tell
> | Linux only lets you have one VT active at any time.  You can
> | have a different mouse and keyboard used by the console and
> | by X (in theory at least), but I don't think that solves the
> | mutual exclusivity of VTs.  
> | 
> |    Some people may have kernel hacks to allow this sort of
> | thing, but I haven't been keeping track of this stuff.  It's
> | not an area that I've been involved in.
> 
> Any idea? Basically I would like to run 2 monitor, one for X
> and one for console paralell, with 1 keyboard/mouse.
> Switching between them like with one monitor, but when no
> work on the one, I would like to keep the signal on the
> unused monitor, eg I would like to see the (not blank) screen.

With the standard linux kernel it is true. You can't have true
multidesktop systems. The console system is not designed for it. 
One it has lots of global variables including locking. Second the 
keyboard driver can't send keyboard input from different keyboards
to different VTs. Can it be done? Yes but it requires a console system
rewrite. Has it been done? Yes I have done it:

http://linuxconsole.sf.net

Will it go into 2.5.X? Well I have piece by piece putting the new console
code into the dj tree to slowly be intergrated into Linus tree. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/


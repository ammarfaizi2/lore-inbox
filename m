Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273534AbRJVPHh>; Mon, 22 Oct 2001 11:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273996AbRJVPH1>; Mon, 22 Oct 2001 11:07:27 -0400
Received: from opengraphics.com ([216.208.162.194]:56265 "EHLO
	hurricane.opengraphics.com") by vger.kernel.org with ESMTP
	id <S272636AbRJVPHK>; Mon, 22 Oct 2001 11:07:10 -0400
Date: Mon, 22 Oct 2001 11:07:41 -0400
To: Walter Harms <WHarms@bfs.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in 2.4.x pc_keyb.c
Message-ID: <20011022110741.A28643@concord.opengraphics.com>
In-Reply-To: <vines.sxdD+tn1pvA@SZKOM.BFS.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vines.sxdD+tn1pvA@SZKOM.BFS.DE>
User-Agent: Mutt/1.3.18i
From: Len Sorensen <lsorense@opengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 04:36:25PM +0100, Walter Harms wrote:
> hi list,
> 
> keyboard disappears with 2.4.x kernel on notebook (compaq amarda)
> 
> After some time the keyboard from my amarda notebook does not respond to anything. The only hint is that 
> "keyboard: Timeout - AT keyboard not present?" appears
> quit often in the syslog before the kbd stops working.
> 
> Comparing the 2.2.x code (no problems) with the 2.4.x code i found pckbd_leds() as prime suspect.
> as you can see it sets kbd_exists = 0 (FALSE) after sending an ENABLE. I am not sure if this is my probleme (read: no time to check if this fix works) but i guess its wrong. 
> 
> Note: 
> 1. the error isnt easy reproduceable but appears only with the 2.4.x 
> 2. send_data returns 1 for  acknowledge  else 0 
> 3. kann sombody please document kbd_exists ?

I have seen this error on every 2.4 and 2.3.99 kernel I have used
on every machine I use.  The machiens I have used it on are all IBM
Intelistation or IBM PC300GL machines.  Whenever the keyboard interrupt
it lost, I either loose the character I just typed (most common), or
get a duplicate of the character.  If it happens when I hit shift, the
shift can get stuck since the release is lost.  Same for ALT and CTRL.
It never happened with any 2.2 kernel.  The keyboard always comes back
after loosing the one character (although I think I have had it die for
about 1 second a few times, although not lately).

Len Sorensen

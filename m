Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSGQM7B>; Wed, 17 Jul 2002 08:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSGQM7A>; Wed, 17 Jul 2002 08:59:00 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:53164 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313419AbSGQM66>;
	Wed, 17 Jul 2002 08:58:58 -0400
Date: Wed, 17 Jul 2002 15:01:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717150153.B19609@ucw.cz>
References: <B27F96E7240@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B27F96E7240@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Wed, Jul 17, 2002 at 02:55:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:55:21PM +0200, Petr Vandrovec wrote:
> On 17 Jul 02 at 14:44, Vojtech Pavlik wrote:
> 
> > > --- a/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> > > +++ b/drivers/input/mouse/psmouse.c     Wed Jul 17 12:19:13 2002
> > > @@ -142,7 +142,7 @@
> > >   */
> > > 
> > >         if (psmouse->type == PSMOUSE_IMEX) {
> > > -               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[2] & 7));
> > > +               input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
> > >                 input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
> > >                 input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
> > >         }
> 
> Hi,
>   any plans to support A4Tech mouse? It uses IMEX protocol, but
>   
> switch(packet[3] & 0x0F) {
>     case 0: /* nothing */
>     case 1: vertical_wheel--; break;
>     case 2: horizontal_wheel++; break;
>     case 0xE: horizontal_wheel--; break;
>     case 0xF: vertical_wheel++; break;
> }
> 
> and obviously it never reports wheel move > 1 in one sample.

Is there a way to detect whether it's an ImEx or A4? Or will we need a
command line parameter ... ?

-- 
Vojtech Pavlik
SuSE Labs

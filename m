Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSGQN66>; Wed, 17 Jul 2002 09:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSGQN66>; Wed, 17 Jul 2002 09:58:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:42928 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314584AbSGQN65>;
	Wed, 17 Jul 2002 09:58:57 -0400
Date: Wed, 17 Jul 2002 16:01:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gunther Mayer <gunther.mayer@gmx.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
Message-ID: <20020717160151.A19935@ucw.cz>
References: <B27F96E7240@vcnet.vc.cvut.cz> <20020717150153.B19609@ucw.cz> <3D3577FD.ED42443C@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3577FD.ED42443C@gmx.net>; from gunther.mayer@gmx.net on Wed, Jul 17, 2002 at 03:58:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 03:58:21PM +0200, Gunther Mayer wrote:

> > > Hi,
> > >   any plans to support A4Tech mouse? It uses IMEX protocol, but
> > >
> > > switch(packet[3] & 0x0F) {
> > >     case 0: /* nothing */
> > >     case 1: vertical_wheel--; break;
> > >     case 2: horizontal_wheel++; break;
> > >     case 0xE: horizontal_wheel--; break;
> > >     case 0xF: vertical_wheel++; break;
> > > }
> > >
> > > and obviously it never reports wheel move > 1 in one sample.
> >
> > Is there a way to detect whether it's an ImEx or A4? Or will we need a
> > command line parameter ... ?
> 
> from http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c :
> 
> char a4tech_id[]={ 0xf3,200, 0xf3,100, 0xf3,80, 0xf3,60, 0xf3,40, 0xf3,20};
> 
> if(a4tech) {
> sendbuf(fd,f,a4tech_id,12);
>         buf[0]=0xf2;
>         write(fd,&buf,1);
>         b=consumefa(f);
>         printf("a4tech ID(f2) is %x\n",b);
> 
>         if(b==6 || b==8) printf("AUTODETECT: a4tech\n");
>         // b=6: spiffy gyro-mouse "8D Profi-Mouse Point Stick"
>         // b=8: boeder Smartmouse Pro (4Button, 2Scrollwheel, 520dpi) PSM_4DPLUS_ID MOUSE_MODEL_4DPLUS
> }

Cool! Anyone send me a patch? ;)

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRDQQgM>; Tue, 17 Apr 2001 12:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132755AbRDQQgC>; Tue, 17 Apr 2001 12:36:02 -0400
Received: from quattro.sventech.com ([205.252.248.110]:60680 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S132754AbRDQQfr>; Tue, 17 Apr 2001 12:35:47 -0400
Date: Tue, 17 Apr 2001 12:35:46 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: FAVRE Gregoire <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
Subject: Re: USB with 2.4.3-ac{1,3,7} without devfs-> aic7xxx ?
Message-ID: <20010417123546.B4295@sventech.com>
In-Reply-To: <20010417004248.A19914@ulima.unil.ch> <20010416185740.Y4295@sventech.com> <20010417182130.A30800@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010417182130.A30800@ulima.unil.ch>; from FAVRE Gregoire on Tue, Apr 17, 2001 at 06:21:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001, FAVRE Gregoire <greg@ulima.unil.ch> wrote:
> Thus spake Johannes Erdfelt (johannes@erdfelt.com):
> 
> > You should probably bring up things like this on the Linux USB list.
> 
> Well, where is that mailing list?

http://www.linux-usb.org

> > What does /proc/interrupts show for the 2.4.3-ac7 case?
> 
> Exactly the same as the one from 2.4.3:
> CPU0       
>   0:      30204          XT-PIC  timer
>   1:        522          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   7:     293087          XT-PIC  aic7xxx, usb-uhci
>   8:          1          XT-PIC  rtc
>  10:        794          XT-PIC  eth0, bttv
>  11:      47362          XT-PIC  saa7146(1)
>  12:       2346          XT-PIC  PS/2 Mouse
>  14:       6615          XT-PIC  ide0
>  15:         37          XT-PIC  ide1
> NMI:          0 
> LOC:      30165 
> ERR:          0
> MIS:          0
> 
> Sorry for the strange looking of my copy and paste to vim...

You may want to turn off auto-indent under vim, or you can always just
remove the excess spaces by hand.

> Maybe the driver don't like IRQ sharing, but I can't change it: aic7xxx
> and usb are onboard, and changing the IRQ for aic7xxx change also the
> one from usb (P2B-LS mother board).

Nope. Both drivers support IRQ sharing just fine.

> > s10sh doesn't use anything under /dev, it's all under /proc/bus/usb,
> > however, you are having a problem before it gets to s10sh at all.
> 
> So, as my only change in config betweem 2.4.3 and 2.4.3-ac[137] was the
> removing of devfs, that's not the problem...

Yeah. I don't think there are any changes in the USB code between 2.4.3
and 2.4.3-ac[137].

I'll have to check and see.

JE


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRDQQVw>; Tue, 17 Apr 2001 12:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132744AbRDQQVm>; Tue, 17 Apr 2001 12:21:42 -0400
Received: from ulima.unil.ch ([130.223.144.143]:56592 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S132743AbRDQQVd>;
	Tue, 17 Apr 2001 12:21:33 -0400
Date: Tue, 17 Apr 2001 18:21:30 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB with 2.4.3-ac{1,3,7} without devfs-> aic7xxx ?
Message-ID: <20010417182130.A30800@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010417004248.A19914@ulima.unil.ch> <20010416185740.Y4295@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010416185740.Y4295@sventech.com>; from johannes@erdfelt.com on Mon, Apr 16, 2001 at 06:57:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Johannes Erdfelt (johannes@erdfelt.com):

> You should probably bring up things like this on the Linux USB list.

Well, where is that mailing list?

> What does /proc/interrupts show for the 2.4.3-ac7 case?

Exactly the same as the one from 2.4.3:
           CPU0       
	     0:      30204          XT-PIC  timer
	       1:        522          XT-PIC  keyboard
	         2:          0          XT-PIC  cascade
		   7:     293087          XT-PIC  aic7xxx, usb-uhci
		     8:          1          XT-PIC  rtc
		      10:        794          XT-PIC  eth0, bttv
		       11:      47362          XT-PIC  saa7146(1)
		        12:       2346          XT-PIC  PS/2 Mouse
			 14:       6615          XT-PIC  ide0
			  15:         37          XT-PIC  ide1
			  NMI:          0 
			  LOC:      30165 
			  ERR:          0
			  MIS:          0

Sorry for the strange looking of my copy and paste to vim...
Maybe the driver don't like IRQ sharing, but I can't change it: aic7xxx
and usb are onboard, and changing the IRQ for aic7xxx change also the
one from usb (P2B-LS mother board).

> s10sh doesn't use anything under /dev, it's all under /proc/bus/usb,
> however, you are having a problem before it gets to s10sh at all.

So, as my only change in config betweem 2.4.3 and 2.4.3-ac[137] was the
removing of devfs, that's not the problem...

Thanks you very much for your answer,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

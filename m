Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUJOUww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUJOUww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJOUww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:52:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39071 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268436AbUJOUws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:52:48 -0400
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
	: oops...]
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1097861761.2820.18.camel@deimos.microgate.com>
References: <Pine.LNX.4.44L0.0410151318580.1052-100000@ida.rowland.org>
	 <1097861761.2820.18.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1097872927.5119.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 16:42:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 13:36, Paul Fulghum wrote:
> Unique device names are useful for identifying
> which device instance is on a particular interrupt
> (/proc/interrupts), but other drivers beside uhci_hcd
> use a constant name so I guess that is legal :-)
> 

I agree that this would be a useful enhancement to the uhci_hcd driver. 
For example:

           CPU0
  0:  183247514          XT-PIC  timer  0/47514
  1:      67096          XT-PIC  i8042  58/67096
  2:          0          XT-PIC  cascade  0/0
  8:   82425669          XT-PIC  rtc  0/25669
 10:  163607273          XT-PIC  uhci_hcd, EMU10K1  0/7273
 11:    1912890          XT-PIC  uhci_hcd, eth0  0/12890
 12:          0          XT-PIC  uhci_hcd  0/0
 15:     244330          XT-PIC  ide1  0/44329

The front panel USB port shares an interrupt with the sound card, the
rear with eth0.  Fome some of my testing it would be helpful if these
just had numbers that I could mentally associate with a USB port.  Right
now I have to move the mouse and watch the interrupt count.

> Either way, the generic IRQ code should deal with
> duplicates without generating an oops.

Agreed, this bug should be fixed either way.

Lee


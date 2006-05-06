Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWEFUh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWEFUh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWEFUh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 16:37:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:17098 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932073AbWEFUh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 16:37:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D2K8hYa7JcdcAyxsaO8KVm98zKAo9bD9yz59nk5yErpfSYLAk5hQu6JLR5rxHIfm7ITQhc6BWY58Nmdxrx9ijXBoUdem51wF7LPNNOPb+o8PadCjVS9lEhJvSYSMTfmRoeJI/gmUiKHd/RgO05SWwquOFiNIfzsGZPrGzqA09dY=
Message-ID: <6e6e20a10605061337r53b918cal38a5048bb284b8ed@mail.gmail.com>
Date: Sat, 6 May 2006 22:37:56 +0200
From: "=?ISO-8859-1?Q?Bj=F6rn_Nilsson?=" <bni.swe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C940, does not work anymore after upgrade to 2.6.15
Cc: akpm@osdl.org, shemminger@osdl.org
In-Reply-To: <20060501131801.341aeb6b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <6e6e20a10601160751v362d2312v6c99fa8db64ce7e1@mail.gmail.com>
	 <20060501131801.341aeb6b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disregard my earlier theories about this problem, they where completely wrong.

Turns out it wasnt a Linux, skge or kernel version related problem at
all. After rebooting about 10 times and swapping network cards in my
computer a couple of times today, I tracked it down to the new
router/adsl-modem my ISP has supplied me with. It turns off its
ethernet port when nothing is connected to it for some reason. Doesnt
turn it on again until I reboot it with some network device connected
and powered on. This made me draw the wrong conclusions about versions
etc earlier, sorry about that.

Regards
/Björn

On 5/1/06, Andrew Morton <akpm@osdl.org> wrote:
>
> If this bug is still present in 2.6.17-rc3, could you please raise a report
> at bugzilla.kernel.org so we can track it?
>
> Thanks.
>
>
> Björn Nilsson <bni.swe@gmail.com> wrote:
> >
> > Hi,
> >
> > I have a problem with the network card attached to my motherboard
> > after doing an upgrade of the kernel from 2.6.11 to 2.6.15.
> >
> > The Motherboard is an ASUS P4P800, and the network card is 3COM 3C940
> > and is afaik a variant of SysKonnect SK-98xx.
> >
> > It worked with 2.6.15 until I shut the system down and started it up
> > again for the first time with 2.6.15 running, and now the card does
> > not work anymore. The driver is loaded, and it detects that the cable
> > is plugged in and the interface is brought up (so says dmesg). The
> > green led on the card is now turned off, it used to be on before.
> >
> > I have tried to reinstall the system from scratch (Using Debian 3.1
> > installer cd), and to my astonishment the card is not working like it
> > used to.
> >
> > It seems like 2.6.15 set the card in some state so it does not work
> > anymore. Is this even possible? I have tried power cycling, even
> > disconnected the power coord from the computer.
> >
> > When i used 2.6.11 I was using the sk98lin driver, when upgrading it
> > is possible the newer skge driver was used, however I am not sure.
> >
> > Debian installer 3.1 uses 2.6.8 kernel with sk98lin driver.
> >
> > I have found others with the same/similar problem:
> > http://bugs.gentoo.org/show_bug.cgi?id=100258
> > http://marc.theaimsgroup.com/?l=linux-netdev&m=112268414417743&w=2
> >
> > But for me the card does not work even with 2.6.15. I dont have
> > Wind*ws to test with, so I cant test the solution in one of the above
> > emails.
> >
> > If the driver in 2.6.15 breaks cards of this type it is qiute a
> > serious bug I think. Anyone have any suggestions as to how I can try
> > to fix this? Reset the card in some way maybe?
> >
> > Please CC me.
> >
> > Regards
> > /Björn
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTAUCBM>; Mon, 20 Jan 2003 21:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbTAUCBM>; Mon, 20 Jan 2003 21:01:12 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:50881 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S266917AbTAUCBL>; Mon, 20 Jan 2003 21:01:11 -0500
Message-ID: <2735779.1043114714658.JavaMail.nobody@web11.us.oracle.com>
Date: Mon, 20 Jan 2003 18:05:14 -0800 (GMT-08:00)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: jt@hpl.hp.com
Subject: Re: irport_net_open issue in 2.5.59
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alessandro Suardi wrote :
> > 
> > [crossposted to IrDA-users and l-k]
>      Hum... This means that the IrDA mailing list archive is broken
> again. Thanks SourceForge.

I misspelt 'sourceforge' on first attempt - shame on me,
 not SF :)

[snip]

> > irport_net_open(), unable to allocate irq=0
> > 
> > It does load, but as expected it doesn't seem to work - irdadump
> > doesn't come up with any line at all.
>      Personally, I've never managed to make irport work, and I know
> that in 2.5.X it's worse.

Uhm - not sure I understand. I thought both ircomm and irport
 were needed, at least it looks like so from this 2.4.21-pre3
 output from my live GPRS link:

[root@dolphin root]# lsmod
Module                  Size  Used by    Not tainted
ircomm-tty             22528   1  (autoclean)
ppp_async               7744   1  (autoclean)
ppp_generic            16060   3  (autoclean) [ppp_async]
slhc                    5200   0  (autoclean) [ppp_generic]
smc-ircc                7520   1  (autoclean)
irport                  5256   1  (autoclean) [smc-ircc]
ircomm                  8712   0  [ircomm-tty]
irda                   94192   1  [ircomm-tty smc-ircc irport ircomm]

 that is, pppd speaks on /dev/ircomm0 - but smc-ircc seems to
 use irport.

>      But, the message above indicate that you fed the driver with
> improper module options. Try to set the proper irq, that would help.

I would gladly oblige :) but how do I know what the proper IRQ
 is ? findchip does tell me that on this CPx750J, but it doesn't
 tell me anything on the C640...

>      Also, Daniele did lot's of work on the new SMC driver (smsc2,
> available on my web page). Maybe you could test this one.


Thanks, will get back with more news soon-ish.

--alessandro

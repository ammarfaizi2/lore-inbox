Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267606AbUHEJAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267606AbUHEJAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267593AbUHEJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 05:00:48 -0400
Received: from smtp05.web.de ([217.72.192.209]:13990 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S267606AbUHEJA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 05:00:29 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Subject: Re: 3c59x very slow with 2.6.X
Date: Thu, 5 Aug 2004 11:00:47 +0200
User-Agent: KMail/1.6.2
References: <200408042203.42367.bernd-schubert@web.de> <4111CD14.30601@bio.ifi.lmu.de>
In-Reply-To: <4111CD14.30601@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051100.48267.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 08:00, you wrote:
> Bernd Schubert wrote:
> > Hello,
> >
> > somehow the network speed is reduced to 14MBit with 2.6.X on my system,
> > with 2.4.X it has full 100MBit.
> > As all our systems boot diskless this is really annoying and I will
> > reboot 2.4.27 soon.
> >
> > euklid:~# nttcp -T hamilton2
> >      Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s  
> > CPU-C/s l  8388608    4.73    4.60     14.2004     14.5911    2048   
> > 433.36     445.3 1  8388608    4.73    0.03     14.1984   2236.9621   
> > 6145   1300.12  204833.3
>
> No problem here: both machines have a 3com 3c905CX-TX and run kernel 2.6.7.
>
> zassenhaus /root# nttcp -T riemann
>       Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s  
> CPU-C/s l  8388608    0.71    0.01     94.9903   7457.3690    2048  
> 2898.87  227580.8 1  8388608    0.71    0.04     93.9984   1598.0964   
> 5794   8115.57  137975.4
>
> The driver is compiled into the kernel, not as module. Could that make a
> difference for you?

Its also compiled into the kernel on our systems. Here are the numbers with 
2.4.27-rc5:

euklid:~# nttcp -T hamilton2

     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l  8388608    0.71    0.04     94.9401   1677.7216    2048   2897.34   51200.0
1  8388608    0.71    0.03     94.1146   2236.9621    5797   8129.81  193233.3

Cheers,
	Bernd

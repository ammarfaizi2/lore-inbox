Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUEXSot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUEXSot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUEXSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:44:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:42472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264432AbUEXSoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:44:39 -0400
Date: Mon, 24 May 2004 11:34:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typo in drivers/usb/class/usblp.c (resend)
Message-Id: <20040524113428.4012a736.rddunlap@osdl.org>
In-Reply-To: <1085393489.6815.30.camel@athlon>
References: <1085393489.6815.30.camel@athlon>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004 12:11:29 +0200 Benoît Dejean wrote:

| i think there's a typo error in usblp.c
| 
| patch against 2.6.6
| 
| --- linux-2.6.6/drivers/usb/class/usblp.c       2004-04-04
| 05:36:26.000000000
| +0200
| +++ linux-2.6.6-modified/drivers/usb/class/usblp.c      2004-05-24
| 01:15:20.000000000 +0200
| @@ -305,7 +305,7 @@
|  
|         if (~status & LP_PERRORP)
|                 newerr = 3;
| -       if (status & LP_POUTPA)
| +       if (~status & LP_POUTPA)
|                 newerr = 1;
|         if (~status & LP_PSELECD)
|                 newerr = 2;
| -- 

Why do you think that there is a typo?  Did you check the USB
printer specification?

LP_PERRORP == 0 means Error.
LP_PSELECD == 0 means Not Selected (or means User disabled the printer).
LP_POUTPA  == 1 means Paper Empty.

See, LP_POUTPA has different error polarity than the other bits.

I don't see a problem.  Are you experiencing some problem with
a USB printer?

--
~Randy

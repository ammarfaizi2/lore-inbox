Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVCLAyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVCLAyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVCLAyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:54:15 -0500
Received: from nacho.zianet.com ([216.234.192.105]:43278 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261823AbVCLAyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:54:10 -0500
From: Steven Cole <elenstev@mesatop.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Problem with PPPD on dialup with 2.6.11-bk1 and later; 2.6.11 is OK
Date: Fri, 11 Mar 2005 17:51:21 -0700
User-Agent: KMail/1.6.1
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk+serial@arm.linux.org.uk>
References: <200503091914.24612.elenstev@mesatop.com> <20050310132114.5eda19d7@dxpl.pdx.osdl.net> <4231FBFD.7000103@tmr.com>
In-Reply-To: <4231FBFD.7000103@tmr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503111751.22138.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 01:13 pm, Bill Davidsen wrote:
> Stephen Hemminger wrote:
> >>Stephen Hemminger also wrote: (Someting's busted with serial in 2.6.11 latest)
> >>
> >>>Some checkin since 2.6.11 has caused the serial driver to
> >>>drop characters.  Console output is chopped and messages are garbled.
> >>>Even the shell prompt gets truncated.
> > 
> > 
> >>Searching lkml archive, I found:
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=111031501416334&w=2
> >>
> >>I also found that reverting that patch made the problem go away for 2.6.11-bk1.
> > 
> > 
> > 
> > Yes, this patch is the problem. A fix showed up today.
> > Current kernels work fine, thanks.
> 
> Could someone who has the patch broken out send it to -stable? Serial 
> not working is a non-trivial issue given the number of people who use 
> dialup either full time or as a fallback connection.
> 
The fix is in:
http://linus.bkbits.net:8080/linux-2.5/cset@422db58ceIvopUVZvMGAN6mhZZ3nPQ?nav=index.html|src/|src/drivers|src/drivers/serial|related/drivers/serial/8250.c

Since the breakage which this fix is for didn't appear until after 2.6.11,
a patch to 2.6.11.x is not required.

Steven

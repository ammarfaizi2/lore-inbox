Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317711AbSHCUYc>; Sat, 3 Aug 2002 16:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317712AbSHCUYc>; Sat, 3 Aug 2002 16:24:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:43252 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317711AbSHCUYc>; Sat, 3 Aug 2002 16:24:32 -0400
Subject: Re: No Subject
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0208032115080.32383-100000@blurp.slackware.pl>
References: <Pine.LNX.4.33.0208032115080.32383-100000@blurp.slackware.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Aug 2002 22:45:18 +0100
Message-Id: <1028411118.1760.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-03 at 20:26, Pawel Kot wrote:
> What helped me was using fixup_device_piix() from -ac in
> ide_scan_pcidev(). My controler's ID is DEVID_ICH3M.
> It is used in a different, more generic way in -ac, so I don't post the
> patch.
> 
> Alan, Marcelo: is there any chance that this change will be ported from
> -ac in 2.4.20?

I plan to send Marcelo all the IDE updates. Note btw the checking of the
return value on pci_enable_device is critical - some old kernels hang on
boot with crappy bioses through not checking.

What I begin to the think the right answer is, is to relax the IDE fixup
block in the i386 kernel boot up. Right now we avoid assigning
unassigned resources for IDE controllers. Clearly we should be doing so.


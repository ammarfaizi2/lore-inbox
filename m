Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319485AbSH3Gq0>; Fri, 30 Aug 2002 02:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319486AbSH3Gq0>; Fri, 30 Aug 2002 02:46:26 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:31689 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S319485AbSH3GqZ>; Fri, 30 Aug 2002 02:46:25 -0400
Date: Fri, 30 Aug 2002 09:51:42 +0300
From: Anssi Saari <as@sci.fi>
To: Markus Plail <plail@web.de>
Cc: Sergio Bruder <sergio@bruder.net>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is enabled
Message-ID: <20020830065142.GA10582@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Markus Plail <plail@web.de>, Sergio Bruder <sergio@bruder.net>,
	Andre Hedrick <andre@linux-ide.org>, vojtech@ucw.cz,
	linux-kernel@vger.kernel.org
References: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org> <20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net> <87d6s0g9eq.fsf@plailis.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6s0g9eq.fsf@plailis.homelinux.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 08:14:53AM +0200, Markus Plail wrote:

> >What is strange is that problem dont appears with ISO images
> >(cdrecord-burned). There is any already-know solution for that problem
> >with VIA686b IDE?

> The problem isn't really the southbridge, the problem is, that the
> kernel doesn't seem to use (I still didn't get a definitive answer)
> DMA when doing things with bigger blocksizes (grabbing audio CDs,
> writing DAO CDs). 

I doubt that's the problem. As I've said before, I don't have this huge
slowdown problem if I plug the writer to a Promise pdc20265 or CMD649,
neither of which supports DMA for ATAPI devices. These controllers
however abort CD writing randomly so they are not a workaround... I
also don't have your DAO vs. TAO problem.

> It seems that older chipsets just deal way better with PIO
> modes (the PIIX3 doesn't have DMA, does it?).

Yes it does.

> For me it helped at least a bit to do the following:
> - Disable interrupt sharing for IDE devices
> - hdparm -d1 -c3 -u0 -X34/66 /dev/burner

I've tried disabling interrupt sharing for IDE that but it didn't
change anything.  hdparm -c3 I haven't tried yet, I'll have to see if
it would help.


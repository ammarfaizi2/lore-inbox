Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHaQXz>; Sat, 31 Aug 2002 12:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSHaQXz>; Sat, 31 Aug 2002 12:23:55 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:35000 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S317622AbSHaQXz>; Sat, 31 Aug 2002 12:23:55 -0400
Date: Sat, 31 Aug 2002 19:29:14 +0300
From: Anssi Saari <as@sci.fi>
To: Markus Plail <plail@web.de>
Cc: Sergio Bruder <sergio@bruder.net>, Andre Hedrick <andre@linux-ide.org>,
       vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is enabled
Message-ID: <20020831162914.GA6310@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	Markus Plail <plail@web.de>, Sergio Bruder <sergio@bruder.net>,
	Andre Hedrick <andre@linux-ide.org>, vojtech@ucw.cz,
	linux-kernel@vger.kernel.org
References: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org> <20020414123935.GA6441@sci.fi> <20020830043346.GA5793@bruder.net> <87d6s0g9eq.fsf@plailis.homelinux.net> <20020830065142.GA10582@sci.fi> <874rdcg62f.fsf@plailis.homelinux.net> <20020830154225.GA6114@sci.fi> <873cswuvvi.fsf@plailis.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cswuvvi.fsf@plailis.homelinux.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 06:58:09PM +0200, Markus Plail wrote:
 
> If you write CDs in RAW modes, then there's the problem with the high
> loads. Examples:
> - cdrecord -raw96r/p (2448 bytes/sector)
> - cdrecord -raw16    (2368 bytes/sector)
> - cdrdao --driver generic-mmc-raw (2368 bytes/sector)
 
Yes, this is confirmed. I tried writing a data track with cdrecord
-raw96r mode and got the slowdown. So yes, it seems that "big" blocks,
2352 bytes and greater cause this problem while "small" blocks of 2048
bytes don't.


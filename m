Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263391AbTDSRkL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTDSRkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 13:40:11 -0400
Received: from mail.ithnet.com ([217.64.64.8]:43794 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263391AbTDSRkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 13:40:10 -0400
Date: Sat, 19 Apr 2003 19:38:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030419193848.0811bd90.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003 09:25:21 -0500 (CDT)
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:

> On Wed, 16 Apr 2003, Stephan von Krawczynski wrote:
> 
> > I just experienced a massive ISDN problem while writing DVDs.
> > It looks like bigger IP packets (bigger than normal ICMP ping)
> > get simply dropped most of the time.
> > I think the packets get lost because some allocation continously fails and
> > disk i/o is faster in re-gaining the mem, but I am not quite sure. Could as
> > well be ide-scsi is partially busy-looping the box to death.
> > As soon as DVD writing is stopped everything comes back to normal.
> > Reading DVDs does not show the problem btw.
> > ping -s 1500 a.b.c.d shows about 5 packets, then stops.
> 
> My best guess would be that IDE blocks IRQs for too long and hisax 
> interrupts get lost. You could try whether hdparm -u1 helps, and a 
> debugging log from the hisax driver may confirm over/underruns.

I don't buy that explanation. Reason is simple: during this all network
connections work flawlessly, and they do have quite a lot of interrupts
compared to ISDN. ISDN is so slow and has so few interrupts that it is quite
unlikely in a SMP-beyond-GHz-limit box that you loose some. The ancient
hardware days are long gone ...

> --Kai

Regards
Stephan

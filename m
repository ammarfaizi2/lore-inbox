Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTEEPeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 11:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTEEPeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 11:34:02 -0400
Received: from mail.ithnet.com ([217.64.64.8]:53009 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262347AbTEEPeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 11:34:01 -0400
Date: Mon, 5 May 2003 17:32:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Karsten Keil <kkeil@suse.de>
Cc: alan@lxorguk.ukuu.org.uk, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030505173249.50a72df9.skraw@ithnet.com>
In-Reply-To: <20030505142300.GC28010@pingi3.kke.suse.de>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	<20030419193848.0811bd90.skraw@ithnet.com>
	<1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
	<20030505142300.GC28010@pingi3.kke.suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003 16:23:00 +0200
Karsten Keil <kkeil@suse.de> wrote:

> Hi Stephan,

Hi Karsten,

long time no hear ;-)

> > Sorry Alan, "been there, done that"
> > I made ISDN work on just about anything that you would call an OS on
> > sometimes quite ancient hardware (compared to nowadays), and I really
> > cannot imagine that the combined (though sometimes confusing) efforts of
> > you, Andre, Pavel, name-one on IDE made a dual 1.4 GHz PIII slower
> > (responding) than a M68k 7,14 MHz with a polling IDE interface - which
> > happens to be the slowest thing I ever did ISDN programming on
> > _flawlessly_.
> > 
> 
> No Alan and Kai are right.
> 
> The problem with the Infineon ISDN chips is that the fifos are small and so
> IRQ latency is relativ critical. 32 or 64 bytes are only 4/8 ms, and if one
> of these 32 Byte is dropped, the complete frame is lost. Modern ethernet
> cards allways have fifos for multiple complete frames, so that such things
> don't happen here.

I know the relatively small fifos. On the other hand compared to the ridiculous
throughput of 8 kByte/sec (single channel) (which most people seem to ignore in
this discussion), it is ok.

Let me simply ask back: is the IDE code in nowadays 2.4 kernel so bad, that a
dual 1,4 GHz PIII cpu with 3 GB ram performs much worse than a 90 MHz P I with
64 MB and OS/2 on it???
_My_ isdn drivers showed _no_ such problems under OS/2 and IDE load...

How did we manage to become that bad?

> You can try to use HFC based ISDN cards (e.g. Conrad: ISDN TA 128K) the
> fifos are much bigger (7.5kB) so at least 4 complete 1500 byte frames can be 
> handled without segmentation. That increase the IRQ latency a lot (~900 ms).

I know HFC is nice. But that cannot mean ISAC/HSCX must have dropouts. You have
to have long interrupt lock outs for such a behaviour, which cannot be intended
at all.

-- 
Regards,
Stephan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbSITJyj>; Fri, 20 Sep 2002 05:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262126AbSITJyj>; Fri, 20 Sep 2002 05:54:39 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:64778 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S262113AbSITJyi>;
	Fri, 20 Sep 2002 05:54:38 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MediaGX/Geode performance fix, Was: Which processor/board for embedded NTP
References: <1032354632.23252.14.camel@venus> <87r8frqech.fsf@zoo.weinigel.se>
	<20020919060218.GD10773@pengutronix.de>
	<873cs5vkfb.fsf_-_@zoo.weinigel.se>
	<1032477107.29021.4.camel@irongate.swansea.linux.org.uk>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 20 Sep 2002 11:59:42 +0200
In-Reply-To: <1032477107.29021.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <87fzw5t20h.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Thu, 2002-09-19 at 20:39, Christer Weinigel wrote:
> > This mail contains a patch to fix a performance problem with many
> > Cyrix MediaGX/NatSemi Geode platforms.  The register settings have
> > been officially recommended by NatSemi themselves.  The patch is
> > against linux-2.4.20-pre7.  Should this be merged into the mainsteam
> > linux kernel?
> 
> This wont actually make an iota of difference in most cases. The CS5530
> IDE driver will force this value to 0x14 anyway. It also sets MWI on te
> X-bus which is needed too.

Ok, it did make a 5% difference when I did some quick tests on TCP
performance.  But I didn't have the CS5530 IDE driver loaded.

> Probably the fixup should be done in the PCI quirks.

Sounds it should be moved from the IDE driver to quirks at least, but
that might be a 2.5 thing in that case.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se

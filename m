Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275349AbTHMTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275352AbTHMTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:40:56 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:39417 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275349AbTHMTkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:40:52 -0400
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: maney@pobox.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <20030813181330.GA1122@furrr.two14.net>
References: <20030812213645.GA1079@furrr.two14.net>
	 <Pine.LNX.4.44.0308131155090.4279-100000@localhost.localdomain>
	 <20030813181330.GA1122@furrr.two14.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060803612.9130.37.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 20:40:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 19:13, Martin Maney wrote:
> At this point the outcome was pretty much a foregone conclusion, but
> yep, reverting to ".id" stopped the corruption for this test case.  As
> Alan said, it "fixed" it only because that incorrect test happens to
> force the driver to use the lower DMA speed. 

Ok

> I suppose the obvious bandaid would be to add a config option or yet
> another /proc/something kluge to let Promise chips be throttled on
> purpose, rather than fortuitously.  For my own use, I think I'm just
> going to reconfigure to avoid the Promise controller on this machine. 

I think the real thing is to find the bug. I guess pdc202xx_old.c needs
an audit at this point.

> I do have one casual question, if someone should have the answer.  The
> driver only talks about a 66MHz high speed; does that mean that the
> 20265 never gets run at its full speed under Linux, or is it just old
> terminology from back when UDMA66 was the top speed?

The latter. 


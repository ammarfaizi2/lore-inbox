Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVLORzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVLORzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVLORzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:55:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51369 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750859AbVLORzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:55:37 -0500
Date: Thu, 15 Dec 2005 17:55:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Linux/m68k <linux-m68k@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] m68k: compile fix - ADBREQ_RAW missing declaration
Message-ID: <20051215175536.GA27946@ftp.linux.org.uk>
References: <20051215085516.GU27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151258200.1605@scrub.home> <20051215171645.GY27946@ftp.linux.org.uk> <Pine.LNX.4.61.0512151832270.1609@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512151832270.1609@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 06:51:40PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Dec 2005, Al Viro wrote:
> 
> > So who should I put as the author?  You or Geert (or whatever attributions
> > might have been in said big patch)?  Incidentally,  ADBREQ_RAW had leaked
> > into mainline (sans definition) in 2.3.45-pre2, which was Feb 13 2000, i.e.
> > more than 1.5 year before your commit, so there's quite a chunk of history
> > missing...
> 
> I'd say Geert, but it probably comes from the Mac tree. Anyway, it 
> wouldn't be such a bad idea to ask him first why it's in his postponed 
> queue:
> 
> http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/POSTPONED/130-adbraw.diff
> 
> My guess it needs some ack from the ppc people.

It doesn't - behaviour in case when ADBREQ_RAW is not passed in flags had
been obviously unchanged.  And only m68k passes ADBREQ_RAW in there.
So no, it doesn't affect ppc at all.

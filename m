Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUHPOMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUHPOMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUHPOMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:12:52 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:1408 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S267659AbUHPOMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:12:48 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
From: davidw@dedasys.com (David N. Welton)
Date: 16 Aug 2004 16:10:55 +0200
Message-ID: <873c2n41hs.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2004-08-15 at 18:45, David N. Welton wrote:

> > but it's not the same problem... I removed the ohci_hcd module
> > from the kernel (it's present at boot), and sleep still doesn't
> > happen.  I don't even get the "breathing" light, and yet the
> > computer still seems warm after some time, seemingly indicative
> > that it's not really asleep or dead.  I can only restart it via
> > the Ctrl-Command-Power combination.

> Best thing at this point is to hack out the sleep code in the video
> driver to see where it dies during the sleep process...

I made the video driver's sleep routing return 0 immediately.

That was enough to at least get a couple of reports from xmon about a
vector 200 corresponding to an address in powerbook_sleep_Core99...
Still investigating, but this is new territory for me, and it's
certainly at a tricky moment in the life of the kernel.  Suggestions
appreciated as to what might have changed and what to look for.

Thankyou,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/

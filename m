Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263063AbVCQNly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263063AbVCQNly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 08:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263066AbVCQNlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 08:41:53 -0500
Received: from orb.pobox.com ([207.8.226.5]:36755 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S263063AbVCQNlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 08:41:51 -0500
Date: Thu, 17 Mar 2005 05:41:47 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050317134147.GA5410@ip68-4-98-123.oc.oc.cox.net>
References: <20050316040654.62881834.akpm@osdl.org> <20050317011811.69062aa0.akpm@osdl.org> <200503171042.33558.petkov@uni-muenster.de> <200503171207.56147.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503171207.56147.petkov@uni-muenster.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 12:07:55PM +0100, Borislav Petkov wrote:
> Hi again,
> 
> since I don't have a 9-pin serial port on my laptop I've been trying to 
> connect it with the testing machine over a 25-pin cable (on a 25-pin port), 
> which, according to the Serial-HOWTO is doable in theory but doesn't seem 
> that easy to do in practice. Setserial reports that the ports are ok:

On laptops, 25-pin ports tend to be parallel, rather than serial. At
least, that's my experience.

[snip]
> but minicom or other serial line communication utils do not send or receive 
> any chars. Any ideas?

Hook a printer up to the 25-pin port (the other end of the cable will
most likely have 36 pins), then use (I think, it's been a while)
/dev/lp0 as your console device, rather than /dev/ttyS#. This assumes
that your kernel has parallel console support compiled in, and that
the parallel port support is compiled in (as opposed to being a module).

And if you do the above, make sure to have lots of paper handy. Also,
this trick probably won't work with all printers, but it stands a good
chance of working.

-Barry K. Nathan <barryn@pobox.com>

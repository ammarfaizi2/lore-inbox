Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTKHAYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTKGWHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:07:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33548 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264358AbTKGOVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 09:21:01 -0500
Date: Fri, 7 Nov 2003 09:10:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <200311061956.hA6JuL6V002039@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1031107090309.20991B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Nov 2003, John Bradford wrote:

> Quote from Linus Torvalds <torvalds@osdl.org>:
> 
> > ide-scsi has always been broken. You should not use it, and indeed there 
> > was never any good reason for it existing AT ALL. But because of a broken 
> > interface to cdrecord, cdrecord historically only wanted to touch SCSI 
> > devices. Ergo, a silly emulation layer that wasn't really worth it.
> 
> Hmmm, but ide-scsi is used for a lot more than cd recorders these
> days.  Alan mentioned 'crazy' SATA devices back in April.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105000779411632&w=2

I mentioned ide tapes and ZIP drives, Linus didn't mention how one gets
around those.

> (Not that I'm suggesting that it is particularly sane to deal with an
> SATA connected printer by presenting it as a SCSI device, but I just
> can't see how ide-scsi could successfully be removed now :-( )

And I don't see the joy of doing so. Unless someone wants to write new
versions of all the SCSI software out in use, a lot of functionality is
lost. In the long run it might have been better to simply fix or rewrite
ide-scsi and stop using the ide interface, becuase disk manufacturers
certainly aren't going to stop making scsi and it needs to be supported
anyway. I guess Doug Gilbert is doing other things now, I would have
expected at least an opinion out of him ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbRHaPcC>; Fri, 31 Aug 2001 11:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRHaPbw>; Fri, 31 Aug 2001 11:31:52 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36603 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266688AbRHaPbi>; Fri, 31 Aug 2001 11:31:38 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 31 Aug 2001 09:31:09 -0600
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac1 RAID-5 resync causes PPP connection to be unusable
Message-ID: <20010831093109.R541@turbolinux.com>
Mail-Followup-To: "Kevin P. Fleming" <kevin@labsysgrp.com>,
	Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <05c501c13178$43e19ba0$6caaa8c0@kevin> <3B8E7F0D.3000503@redhat.com> <000d01c131d4$a8449820$6caaa8c0@kevin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01c131d4$a8449820$6caaa8c0@kevin>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2001  21:23 -0700, Kevin P. Fleming wrote:
> OK, I see that now... and it looks like the risks associated with setting
> the unmaskirq flags on my drives (none of the four drives have it set now)
> are too great to be worth playing with it. I'll just not use my PPP
> connection during these particularly heavy disk activity moments. Thanks for
> the quick response.

There was a kernel patch (or possibly a user-space tool) which allowed
one to change the "priority" of IRQs and their handlers.  This was back
in the 1.2 or 2.0 days, when _any_ disk or other interrupt activity might
be enough to cause problems for serial connections (especially if you
only had a 16450 UART (1 byte buffer) instead of a 16550 (16 byte buffer).
You could make your serial interrupt (handler) take priority over disk
interrupts.

Maybe Ted Ts'o or other long-time Linux folks will know what was actually
called, and whether it is still applicable to modern hardware/kernel.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284432AbRLXEF7>; Sun, 23 Dec 2001 23:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284444AbRLXEFu>; Sun, 23 Dec 2001 23:05:50 -0500
Received: from gherkin.frus.com ([192.158.254.49]:1152 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S284432AbRLXEFi>;
	Sun, 23 Dec 2001 23:05:38 -0500
Message-Id: <m16IMMg-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> "from Peter Osterlund at Dec 23,
 2001 06:44:43 pm"
To: Peter Osterlund <petero2@telia.com>
Date: Sun, 23 Dec 2001 22:05:26 -0600 (CST)
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> When trying to mount an ISO9660 CD on my USB CDRW unit, I get lots
> of "sr: unaligned transfer" messages from the kernel and the mount
> command fails. This message was added in kernel 2.5.1 and the
> sr_scatter_pad() function was removed at the same time.

I'm in the same boat except for my CDRW unit being SCSI.

> So, what changes are needed to make CD support work?

Evidently non-trivial...  I tried a quick hack at putting the
sr_scatter_pad() code back into sr.c, but without success: null
pointer dereference when I tried to mount an ISO9660 CD.  I think
I'll enjoy the holiday week and wait for Jens to produce the proper
fix :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSC0W60>; Wed, 27 Mar 2002 17:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293277AbSC0W6G>; Wed, 27 Mar 2002 17:58:06 -0500
Received: from ohiper1-235.apex.net ([209.250.47.250]:35337 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293203AbSC0W55>; Wed, 27 Mar 2002 17:57:57 -0500
Date: Wed, 27 Mar 2002 16:55:49 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Berend De Schouwer <bds@jhb.ucs.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA text console corruption and fix.
Message-ID: <20020327225549.GA5337@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Berend De Schouwer <bds@jhb.ucs.co.za>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1017256651.18224.40.camel@bds.ucs.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 16:51:37 up 21:27,  0 users,  load average: 1.26, 1.13, 1.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 09:17:30PM +0200, Berend De Schouwer wrote:
[...]
> I have 3000+ identical VIA KT133/Duron 750MHz machines.  In 20% of these
> the bug is visible, in the others, it isn't.  The machines run in an
> LTSP-ish configuration.  The machines are supposed to be identical (they
> were bought together), but have different revisions of BIOS versions,
> etc.  They have on-board S3 Savage cards that steal RAM from the main
> RAM.

Aha, another.  You're the fourth or fifth person with this problem.  I
have a patch very similar to yours.  What my patch does is only clear
bit 7, which is what was experimentally determined to disable the Write
Memory Queue.  So far it seems that only KM133 (KT133 w/onboard S3
Savage) are afflicted.

However, the patch isn't being accepted until an explanation from VIA is
obtained (apparently the head kernel honcho's were explicitly told to
clear bit 5).  I'm working on that now.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

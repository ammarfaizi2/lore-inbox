Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbQL1FpY>; Thu, 28 Dec 2000 00:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132368AbQL1FpP>; Thu, 28 Dec 2000 00:45:15 -0500
Received: from tantalophile.demon.co.uk ([193.237.65.219]:57093 "EHLO
	thefinal.cern.ch") by vger.kernel.org with ESMTP id <S131245AbQL1FpG>;
	Thu, 28 Dec 2000 00:45:06 -0500
Date: Thu, 28 Dec 2000 06:15:46 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Steve Grubb <ddata@gate.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] performance enhancement for simple_strtoul
Message-ID: <20001228061546.A4578@thefinal.cern.ch>
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master> <20001220100446.A1249@inetnebr.com> <001401c06ab4$ac8615e0$7d1a24cf@master> <20001221010935.A22817@pcep-jamie.cern.ch> <20001221210637.C1545@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001221210637.C1545@bug.ucw.cz>; from pavel@suse.cz on Thu, Dec 21, 2000 at 09:06:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > [about strtoul]
> > Perhaps I am mistaken but I'd expect it to be called what, ten times at
> > boot time, and a couple of times when X loads the MTRRs?
> 
> On second thought, ps -auxl maybe stresses simple_strtoul a little
> bit. Not sure.

Nah.  proc_pid_lookup does its own conversion from string to number, and
the rest are conversions from numbers to strings in sprintf.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLEXwj>; Tue, 5 Dec 2000 18:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLEXw3>; Tue, 5 Dec 2000 18:52:29 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:14342 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129183AbQLEXwS>; Tue, 5 Dec 2000 18:52:18 -0500
Date: Tue, 5 Dec 2000 17:21:22 -0600
To: ryan <ryan@javien.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Change of /proc/cpuinfo format
Message-ID: <20001205172122.H6567@cadcamlab.org>
In-Reply-To: <3A2D7505.2BB48C48@javien.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A2D7505.2BB48C48@javien.com>; from ryan@javien.com on Tue, Dec 05, 2000 at 03:06:45PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not quite sure why the name change is necessary, and even if one
> wants to keep the name change there is a discontunity of cpuinfo
> formats and programs which intend to run on kernels 2.2 and 2.4 needs
> to know this...

The reason is that HPA, who did the recent IA32 CPU detection cleanup,
felt that the information reported in the new 'features' field was
sufficiently different from that reported in the old 'flags' field that
it was worth renaming -- so that programs wouldn't try to rely on the
old flag names.

(Specifically: some flags were renamed to be distinct between Intel,
AMD, etc, because the exact behavior of the flag may vary between
brands.)

> -			        "features\t:",
> +			        "flags\t:",

This patch is already in test12pre5, and is wrong.  You need two tabs
after 'flags'.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

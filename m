Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRAaGPH>; Wed, 31 Jan 2001 01:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRAaGO5>; Wed, 31 Jan 2001 01:14:57 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:63753 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129810AbRAaGOx>; Wed, 31 Jan 2001 01:14:53 -0500
Date: Wed, 31 Jan 2001 00:14:40 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Keith Owens <kaos@ocs.com.au>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Version 2.4.1 cannot be built.
Message-ID: <20010131001440.B18746@cadcamlab.org>
In-Reply-To: <Pine.LNX.3.95.1010130175517.3672A-100000@chaos.analogic.com> <Pine.LNX.3.95.1010130180303.4483A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.3.95.1010130180303.4483A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Jan 30, 2001 at 06:07:32PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Richard B. Johnson]
> Bob Tracy found the problem: the second ':' really needs to be
> escaped even though newer versions of make allow what was written.

> -$(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)
> +$(MODINCL)/%.ver: CFLAGS \:= -I./include $(CFLAGS)

No, that's a workaround in that it subverts the purpose of the line.
(In which case, better to delete the line entirely.)  The correct fix
is to upgrade to a version of 'make' that understands the syntax used
there.  Yes, the FSF being the FSF, they keep adding features to their
software.  And yes, some of us are using some of those features.

It could have been worse.  Documentation/Changes lists version 3.77,
from July 1998.  We (at least I) actually considered using features
from 3.78, but that was quickly shot down since 3.78 is too new -
September 1999.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

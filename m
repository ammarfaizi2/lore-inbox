Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKH17>; Mon, 11 Dec 2000 02:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLKH1u>; Mon, 11 Dec 2000 02:27:50 -0500
Received: from ja.ssi.bg ([193.68.177.189]:7172 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S129314AbQLKH1e>;
	Mon, 11 Dec 2000 02:27:34 -0500
Date: Mon, 11 Dec 2000 08:57:19 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
cc: srwalter@yahoo.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <14900.9881.51332.993356@critterling.garfield.home>
Message-ID: <Pine.LNX.4.21.0012110833530.855-100000@u>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sun, 10 Dec 2000, Victor J. Orlikowski wrote:

> You appear to be right, sir.
> The SVGA xserver was what I was using. Changing over to use the S3
> server, and then adding back in MTRRs, seems to have solved the

	Hm, I have to see whether GX2 works with the S3V server. May
be GX2 is not supported.

> trouble. I'll let you know if it returns, but for now, all appears
> well.

	I'm using XF86_SVGA and it seems the s3v driver in 3.3.* and
may be 4.0.* (as mentioned in the xfree-xpert list) has problem with
the right usage of the accel FIFO for the GX2 cards. Not sure for
your S3Trio32/64 card. It seems the faster CPU and the AGP speed hits the
problem. I see some problems in the image (some dots are missing from
different letters, sometimes).

	regs3v.h approximates the loop to 6 seconds:
#define MAXLOOP 0xffffff /* timeout value for engine waits, ~6 secs */

	For my CPU the lockup takes 4.8 seconds. Not sure why they are
sometimes infinite.

	So, I'm leaving this mail list, it seems this is a s3v driver
problem.

> Victor

In-Reply-To:
http://marc.theaimsgroup.com/?l=xfree-xpert&r=1&w=2


Regards

--
Julian Anastasov <ja@ssi.bg>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

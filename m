Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbTCJVTD>; Mon, 10 Mar 2003 16:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbTCJVTD>; Mon, 10 Mar 2003 16:19:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63362 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261481AbTCJVSt>; Mon, 10 Mar 2003 16:18:49 -0500
Date: Mon, 10 Mar 2003 16:32:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Luben Tuikov <luben@splentec.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] coding style addendum
In-Reply-To: <3E6CFC04.7000401@splentec.com>
Message-ID: <Pine.LNX.3.95.1030310162308.14367A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003, Luben Tuikov wrote:

> Someone may find this helpful and descriptive of how kernel code
> should be developed.
[SNIPPED...]

> +      Make sure every module/subroutine hides something.

This is not correct. Well known example:

#include <math.h>

double hypot(double x, double y) {
    return sqrt((x * x) + (y * y));
}

This subroutine hides nothing. It receives input parameters
and returns the result of its operations. Such a subroutine
is properly implemented and should not be be forced to hide
anything.

The input parameters are copies, owned by the called function.
They can be manipulated like local data and must not be required
to be copied into "local data". The return value is also not
locally stored and therefore not hidden. Your rule would require
the replication of three floating-point variables NotGood(tm).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129476AbQK1Aca>; Mon, 27 Nov 2000 19:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129539AbQK1AcV>; Mon, 27 Nov 2000 19:32:21 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:17412 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129476AbQK1AcN>; Mon, 27 Nov 2000 19:32:13 -0500
Date: Mon, 27 Nov 2000 18:01:58 -0600
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127180158.G8881@wire.cadcamlab.org>
In-Reply-To: <20001125235511.A16662@redhat.com> <Pine.LNX.4.21.0011261036001.1015-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011261036001.1015-100000@penguin.homenet>; from tigran@veritas.com on Sun, Nov 26, 2000 at 10:37:07AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tigran Aivazian]
> _BUT_ never let this to be a default option, please.  Because there
> are valid cases where a programmer things "this is in .data" and that
> means this should be in .data.

If you are writing the sort of code that cares which section it ends up
in, you need to use __attribute__((section)).  You probably will be
using things like __attribute__((align)) as well.  Relying on compiler
behavior here is dangerous.

I agree though that an option is called for, either -fassume-bss-zero
or -fno-assume-bss-zero, not sure which should be the default.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

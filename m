Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131083AbQLNTI7>; Thu, 14 Dec 2000 14:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbQLNTIt>; Thu, 14 Dec 2000 14:08:49 -0500
Received: from vp175103.reshsg.uci.edu ([128.195.175.103]:4615 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131083AbQLNTIk>; Thu, 14 Dec 2000 14:08:40 -0500
Date: Thu, 14 Dec 2000 10:38:01 -0800
Message-Id: <200012141838.eBEIc1v08746@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <3A38B9C8.B11C4ABC@haque.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18pre23 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000 07:15:04 -0500, Mohammad A. Haque <mhaque@haque.net> wrote:
> Were you connected to a network or receiving/sending anything?

ip_defrag is broken -- there is an obvious NULL pointer dereference
in it, introduced in test12. It doesn't hit normally, because of
path MTU discovery, but using NFS causes instant death.

I won't venture a fix, as I don't know the networking code well
enough. So far, no networking maintainer has had anything to say
about this bug on the list...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132607AbRA0KKO>; Sat, 27 Jan 2001 05:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132641AbRA0KJy>; Sat, 27 Jan 2001 05:09:54 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:23050 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S132607AbRA0KJw>; Sat, 27 Jan 2001 05:09:52 -0500
Date: Sat, 27 Jan 2001 02:09:41 -0800
Message-Id: <200101271009.f0RA9fb04363@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
        Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A728475.34CF841@uow.edu.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001 19:19:01 +1100, Andrew Morton <andrewm@uow.edu.au> wrote:

> The figures I quoted for the no-hw-checksum case were still
> using scatter/gather.  That can be turned off as well and
> it makes it a tiny bit quicker.

Hmm. Are you sure the differences are not just noise? Unless you
modified the zerocopy patch yourself, it won't use SG without
checksums...

In fact it would be interesting to revert that policy and
see how much SG alone helps. Probably not much, since the
CPU checksumming is close to onecopy.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

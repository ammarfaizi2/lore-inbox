Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTFYVrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTFYVrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:47:51 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:40196 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP id S264987AbTFYVru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:47:50 -0400
To: Chris Mason <mason@suse.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Oleg Drokin <green@namesys.com>
Subject: Re: 2.4.21 reiserfs oops
References: <87he6iyzyj.fsf@amaterasu.srvr.nix>
	<20030623095356.GA12936@namesys.com>
	<87k7bcxww4.fsf@amaterasu.srvr.nix>
	<20030624053129.GA24025@namesys.com>
	<8765mvxlhs.fsf@amaterasu.srvr.nix>
	<1056488965.10097.60.camel@tiny.suse.com>
From: Nix <nix@esperi.demon.co.uk>
X-Emacs: it's all fun and games, until somebody tries to edit a file.
Date: Wed, 25 Jun 2003 22:47:09 +0100
In-Reply-To: <1056488965.10097.60.camel@tiny.suse.com> (Chris Mason's
 message of "24 Jun 2003 17:09:26 -0400")
Message-ID: <87wuf9x21u.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[reiserfs excised as this is no longer quite on-topic]

On 24 Jun 2003, Chris Mason said:
> The EIP isn't zero or 1, you've got a bad null pinter dereference at
> address 1.  You get this when you do something like *(char *)1 =
> some_val.

Ah. That does sound like either bad RAM or scattershot corruption.

> The ram is most likely bad, you're 1 bit away from zero, but you might
> try a reiserfsck on any drives affected by the scsi errors.

Done that, no problems found. (Most drives are e3fs.)

2.4.21's crashed once more since then, network driver death; I'm
probably going to revert to 2.4.20 on that box, which ran perfectly
since three days past 2.4.20's release. (However, several other boxes
had problems with 2.4.20 which were cleared up with .21... you win some,
you lose some. I'd say this has been a net gain.)

I'll see if 2.4.20 has the same problems; if it does, then I agree, the
RAM's probably had it.

-- 
`It is an unfortunate coincidence that the date locarchive.h was
 written (in hex) matches Ritchie's birthday (in octal).'
               -- Roland McGrath on the libc-alpha list

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTFWWTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTFWWRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:17:11 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:52491 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP id S265394AbTFWWQU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:16:20 -0400
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.4.21 reiserfs oops
References: <87he6iyzyj.fsf@amaterasu.srvr.nix>
	<20030623095356.GA12936@namesys.com>
From: Nix <nix@esperi.demon.co.uk>
X-Emacs: because Hell was full.
Date: Mon, 23 Jun 2003 23:16:27 +0100
In-Reply-To: <20030623095356.GA12936@namesys.com> (Oleg Drokin's message of
 "Mon, 23 Jun 2003 13:53:56 +0400")
Message-ID: <87k7bcxww4.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jun 2003, Oleg Drokin said:
> Hello!
> 
> On Sun, Jun 22, 2003 at 03:00:20PM +0100, Nix wrote:
> 
>> Jun 22 13:52:42 loki kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001 
> 
> This is very strange address to oops on.

I'll say! Looks almost like it JMPed to a null pointer or something.

>> Jun 22 13:52:43 loki kernel: EIP:    0010:[<c0092df4>]    Not tainted 
> 
> And the EIP is prior to kernel start which is also very strange.
> On the other hand the address c0192df4 is somewhere inside reiserfs code,
> so it looks like a single bit error, I'd say.

I think it unlikely to be RAM problems given that the problem happened
shortly after upgrading to 2.4.21; this was about half a day after I
rebooted it because it threw a pile of never-seen-again, un-syslogged
SCSI abort errors at me (sym53c875); and *that* was a few minutes after
I rebooted into 2.4.21 for the first time.

All my other boxes love 2.4.21, but this one dislikes it. (Of course it
has to be my second-most-critical server... ah well, the NFS problems
in 2.4.20 bit my most critical server and my home directory both, so
I guess this is less unpleasant.)

> Can you run memtest86 for some time to verify that your RAM is OK?

Did that last night; no problems reported. (Not really surprising.)

> (hm, and the oops got twice to the logs which is pretty strange thing, too,
> never seen anything like this).

That's my weirdly broken syslog config. I've never got around to fixing
it; it only happens with kernel messages and I don't get all that many
of those.

-- 
`It is an unfortunate coincidence that the date locarchive.h was
 written (in hex) matches Ritchie's birthday (in octal).'
               -- Roland McGrath on the libc-alpha list

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFXUqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTFXUqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:46:34 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:34575 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP id S261428AbTFXUqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:46:32 -0400
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.4.21 reiserfs oops
References: <87he6iyzyj.fsf@amaterasu.srvr.nix>
	<20030623095356.GA12936@namesys.com>
	<87k7bcxww4.fsf@amaterasu.srvr.nix>
	<20030624053129.GA24025@namesys.com>
From: Nix <nix@esperi.demon.co.uk>
X-Emacs: the Swiss Army of Editors.
Date: Tue, 24 Jun 2003 21:34:55 +0100
In-Reply-To: <20030624053129.GA24025@namesys.com> (Oleg Drokin's message of
 "Tue, 24 Jun 2003 09:31:29 +0400")
Message-ID: <8765mvxlhs.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, Oleg Drokin moaned:
> Hello!
> 
> On Mon, Jun 23, 2003 at 11:16:27PM +0100, Nix wrote:
> 
>> >> Jun 22 13:52:42 loki kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001 
>> > This is very strange address to oops on.
>> I'll say! Looks almost like it JMPed to a null pointer or something.
> 
> No, if it'd jumped to a NULL pointer, we'd see 0 in EIP.

JMPed to ((long)NULL)+1 or something then :) the fact remains that it's
not somewhere that even a memory error would make us likely to jump to.

>> >> Jun 22 13:52:43 loki kernel: EIP:    0010:[<c0092df4>]    Not tainted 
>> > And the EIP is prior to kernel start which is also very strange.
>> > On the other hand the address c0192df4 is somewhere inside reiserfs code,
>> > so it looks like a single bit error, I'd say.
>> I think it unlikely to be RAM problems given that the problem happened
>> shortly after upgrading to 2.4.21; this was about half a day after I
>> rebooted it because it threw a pile of never-seen-again, un-syslogged
>> SCSI abort errors at me (sym53c875); and *that* was a few minutes after
>> I rebooted into 2.4.21 for the first time.
> 
> Hm, so first there were some scsi problems and then reiserfs oops?

Different boots. I upgraded, the first boot crashed within five minutes
with weird SCSI errors, so I rebooted again and this happened six hours
later.

I'm willing to write off the SCSI errors to the shock effect of having
just been powered down for the first time in a year (the shutdown
scripts didn't quite work and the reset button is disconnected).

>> Actually since the RAM is good, I see no good reason for this to happen.
>> (actually I see no good reason for valid code before _text, either).
> 
> I wonder if 2.4.21 constantly crashes like that for you, then?

No obvious sign of it:

  9:34pm  up 1 day 22:30,  14 users,  load average: 0.09, 0.12, 0.16

(it is of course waiting until I am hundreds of miles away. *Then* it'll
crash.)

-- 
`It is an unfortunate coincidence that the date locarchive.h was
 written (in hex) matches Ritchie's birthday (in octal).'
               -- Roland McGrath on the libc-alpha list

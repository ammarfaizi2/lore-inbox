Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265704AbTFXFR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbTFXFR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:17:27 -0400
Received: from angband.namesys.com ([212.16.7.85]:24224 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265704AbTFXFRW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:17:22 -0400
Date: Tue, 24 Jun 2003 09:31:29 +0400
From: Oleg Drokin <green@namesys.com>
To: Nix <nix@esperi.demon.co.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.4.21 reiserfs oops
Message-ID: <20030624053129.GA24025@namesys.com>
References: <87he6iyzyj.fsf@amaterasu.srvr.nix> <20030623095356.GA12936@namesys.com> <87k7bcxww4.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k7bcxww4.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jun 23, 2003 at 11:16:27PM +0100, Nix wrote:

> >> Jun 22 13:52:42 loki kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001 
> > This is very strange address to oops on.
> I'll say! Looks almost like it JMPed to a null pointer or something.

No, if it'd jumped to a NULL pointer, we'd see 0 in EIP.

> >> Jun 22 13:52:43 loki kernel: EIP:    0010:[<c0092df4>]    Not tainted 
> > And the EIP is prior to kernel start which is also very strange.
> > On the other hand the address c0192df4 is somewhere inside reiserfs code,
> > so it looks like a single bit error, I'd say.
> I think it unlikely to be RAM problems given that the problem happened
> shortly after upgrading to 2.4.21; this was about half a day after I
> rebooted it because it threw a pile of never-seen-again, un-syslogged
> SCSI abort errors at me (sym53c875); and *that* was a few minutes after
> I rebooted into 2.4.21 for the first time.

Hm, so first there were some scsi problems and then reiserfs oops?

Actually since the RAM is good, I see no good reason for this to happen.
(actually I see no good reason for valid code before _text, either).

I wonder if 2.4.21 constantly crashes like that for you, then?

Bye,
    Oleg

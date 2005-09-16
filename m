Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbVIPPYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbVIPPYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbVIPPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:24:49 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:56327 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1161110AbVIPPYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:24:49 -0400
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org, ivan.korzakow@gmail.com,
       fawadlateef@gmail.com
Subject: Re: best way to access device driver functions
References: <a5986103050915004846d05841@mail.gmail.com>
	<1e62d137050915010361d10139@mail.gmail.com>
	<a598610305091505184a8aa8fd@mail.gmail.com>
	<1e62d13705091508391832f897@mail.gmail.com>
	<87mzmduq1h.fsf@amaterasu.srvr.nix>
	<1126879660.3103.6.camel@localhost.localdomain>
From: Nix <nix@esperi.org.uk>
X-Emacs: resistance is futile; you will be assimilated and byte-compiled.
Date: Fri, 16 Sep 2005 16:24:15 +0100
In-Reply-To: <1126879660.3103.6.camel@localhost.localdomain> (Arjan van de
 Ven's message of "16 Sep 2005 15:10:20 +0100")
Message-ID: <87irx1ujc0.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2005, Arjan van de Ven noted:
> 
>> New *system calls* are generally avoided (especially if they might be
>> useful to non-privileged code) because they come with a *very* high
>> backward compatibility burden
> 
> ioctls come with the same burden though.

Well, sort of. A lot of ioctl()s are widely-known and surely can't be
changed, just like syscalls (e.g. the terminal control stuff) --- but
in the past even things like the HD geometry ioctls have changed,
and ioctl()s specific to, say, a single obscure block device could
probably change without requiring recompilation of more than one or
two userspace programs (and this has happened).

Indeed, one of the problems with ioctl()s is that there is no clear
delineation: some ioctl()s are heavily used and some are totally
unused, and it's never clear which is which in all cases.

(I suppose this is sort of true of syscalls too --- how many people call
sys_uselib()? --- but to a much lesser extent, because there's no such
thing as an `obscure device-specific syscall'.)

-- 
`One cannot, after all, be expected to read every single word
 of a book whose author one wishes to insult.' --- Richard Dawkins

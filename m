Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVAaRcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVAaRcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVAaRcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:32:24 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:55050 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261277AbVAaRbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:31:12 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: SPARC64 mapped figure goes unsignedly negative...
References: <87sm4izw3u.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0501311256580.5368@goblin.wat.veritas.com>
	<87sm4hwr81.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0501311545200.5933@goblin.wat.veritas.com>
	<87d5vlwp8k.fsf@amaterasu.srvr.nix>
	<Pine.LNX.4.61.0501311642400.6072@goblin.wat.veritas.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's not slow --- it's stately.
Date: Mon, 31 Jan 2005 17:31:04 +0000
In-Reply-To: <Pine.LNX.4.61.0501311642400.6072@goblin.wat.veritas.com> (Hugh
 Dickins's message of "Mon, 31 Jan 2005 17:06:29 +0000 (GMT)")
Message-ID: <87vf9dv73b.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005, Hugh Dickins uttered the following:
> On Mon, 31 Jan 2005, Nix wrote:
>> Filename				Type		Size	Used	Priority
>> /dev/sda2                               partition	523016	0	1
>> /dev/sda4                               partition	511232	57648	2
>> /dev/sdb2                               partition	523016	0	1
>> 
>> Is the problem that the higher-priority kicking out to swap which should
>> happen when memory is tight, won't?
> 
> I had thought that it was any kicking out to swap - apart from kicking
> tmpfs/shmem pages to swap, which should happen independently of Mapped.
> 
> If you're not using tmpfs or shmem, then I'm surprised by that figure.

Oh. Yes, tmpfs might just about explain it:

58320	/tmp

So it looks like I have a swap-free box for a time. I guess I'd better
be careful... :)

> There was 88 kB out to swap in your original /proc/meminfo, which we
> may suppose was before Mapped went negative; but above shows more since.

Yes, I expect so. It must've gone negative really rather early: and note
that it's some distance below 2^64 by now, so it's still falling.  If I
wait for a billion years or so it might wrap around. :)

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery

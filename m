Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314265AbSD0Pgu>; Sat, 27 Apr 2002 11:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSD0Pgt>; Sat, 27 Apr 2002 11:36:49 -0400
Received: from [195.223.140.120] ([195.223.140.120]:61035 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314265AbSD0Pgt>; Sat, 27 Apr 2002 11:36:49 -0400
Date: Sat, 27 Apr 2002 17:36:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: hgchewml@optusnet.com.au,
        "'Linux kernel mailing list'" <linux-kernel@vger.kernel.org>,
        riel@conectiva.com.br
Subject: Re: File corruption when running VMware.
Message-ID: <20020427173659.A1631@dualathlon.random>
In-Reply-To: <37A7BD60863@vcnet.vc.cvut.cz> <20020427010134.M19278@dualathlon.random> <20020427015623.P19278@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2002 at 01:56:23AM +0200, Andrea Arcangeli wrote:
> enabled of course). If I'll find any instability of the host OS I'll let
> you know, so far it looks solid.

The instability appears only during the poweron/resume, I left it running
for a long time and it was solid, but only after I now restarted/stopped
it a few times it showed stability problems still. If the poweron
doesn't reboot the machine then it is solid (that's why I couldn't
notice it yesterday). Also correcting the #if 0 in the patch or adapting
the lower part doesn't help. The big question is: are them the only two
places touching the pagetables? I also wonder why you're using cr3
instead of using the pointer in current->mm, I assume they're different
and that you swap the cr3 internally to the vmware module during ctx
switches of tasks?

thanks,

Andrea

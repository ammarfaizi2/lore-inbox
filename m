Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbULaFip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbULaFip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 00:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbULaFip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 00:38:45 -0500
Received: from nevyn.them.org ([66.93.172.17]:24005 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261841AbULaFia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 00:38:30 -0500
Date: Fri, 31 Dec 2004 00:38:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041231053822.GB25850@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jesse Allen <the3dfxdude@gmail.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com> <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org> <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <5304685704123020553f0ef982@mail.gmail.com> <Pine.LNX.4.58.0412302100320.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412302100320.2280@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 09:05:01PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 30 Dec 2004, Jesse Allen wrote:
> > 
> > Well I tried this patch and it works. 
> 
> Goodie. Are there other known problems with silly copy-protection 
> schemes?  It migth be worth testing.
> 
> However:
> 
> > Since I cannot spot any issue, the patch looks good.  Are there any
> > other test cases?
> 
> Yes. It seems I broke "strace" with it. Probably the difference in system
> call trace reporting that Dan Jacobowitz already pointed out.
> 
> Now, that should be easily handled by just separating out the cases of 
> system call tracing and debug trap handling, and using the old silly code 
> for system calls. I'd prefer a cleaner approach, but that seems to be the 
> sane thing to do for now.

Strace doesn't use PTRACE_SETOPTIONS as far as I can tell... so it must
be something different.

-- 
Daniel Jacobowitz

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSANXio>; Mon, 14 Jan 2002 18:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289297AbSANXif>; Mon, 14 Jan 2002 18:38:35 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:63828 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289296AbSANXiW>; Mon, 14 Jan 2002 18:38:22 -0500
Date: Mon, 14 Jan 2002 18:38:20 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
Message-ID: <20020114183820.G30639@redhat.com>
In-Reply-To: <20020114165909.A20808@thyrsus.com> <20020114173542.C30639@redhat.com> <20020114173854.C23081@thyrsus.com> <20020114180007.D30639@redhat.com> <20020114180522.A24120@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114180522.A24120@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 06:05:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:05:22PM -0500, Eric S. Raymond wrote:
> Because fetchmail is doing the same thing any other MTA would do in that
> situation -- throwing up its hands, because it doesn't have and can't get
> the information to compensate for the misconfiguration.

Nice cop out.  Fetchmail is a hybrid MTA+MUA.  Since it straddles the 
line, it should follow the rules of least surprise, namely:

	1. don't delete a messages without knowing they can be / are 
	   delivered successfully
	2. make sure error messages that come from temporary config 
	   issues are sent to the person who can fix them.

FYI, it's easy to fix, just use the correct ordering of download, transmit, 
delete that sendmail and other MTAs use.  Sendmail doesn't delete a message 
out of its spool just because it was sent to the next MTA in the chain, 
instead it *waits* for the next MTA to acknowledge the successful receipt 
of the message.  Funnily, it even fsync()s the spool before acknowledging 
incoming messages.

> If you have some magic patch to fix this, I'll take it.  If you have
> nothing constructive to contribute, please take your venom elsewhere.

Eric, you're asking kernel developers to trust that you are dealing with 
the design issues correctly.  Part of that means understanding where the 
priorities of the issues that concern you fit in with the rest of the 
project.  That means understanding what current practice is, and what it 
will be to all the players involved (core kernel developers, bleeding edge 
users, end users who want a stable system, distro users, distro developers).  
So far, I see proof that you are not good at understanding design issues 
that don't interest you.  This flame war is proof that you're very out of 
sync with the rest of the developers.  I'm asking you to show some goodwill 
by going back and fixing the design issues in your own project in order 
to better understand some of the currents at work.  Until then, I won't 
use fetchmail, and I pity the poor users that do.

		-ben

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbUL2O5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUL2O5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbUL2O5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:57:43 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:14565 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S261352AbUL2O5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:57:41 -0500
From: Mike Hearn <mh@codeweavers.com>
To: Thomas Sailer <sailer@scs.ch>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Jesse Allen <the3dfxdude@gmail.com>, Daniel Jacobowitz <dan@debian.org>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <1104286459.7640.54.camel@gamecube.scs.ch>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <419E42B3.8070901@wanadoo.fr>
	 <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
	 <419E4A76.8020909@wanadoo.fr>
	 <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
	 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
Organization: Codeweavers, Inc
Date: Wed, 29 Dec 2004 15:02:38 +0000
Message-Id: <1104332559.3393.16.camel@littlegreen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-SPF-Flag: YES
X-SA-Exim-Connect-IP: 81.97.76.53
X-SA-Exim-Mail-From: mh@codeweavers.com
Subject: Re: ptrace single-stepping change breaks Wine
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 03:14 +0100, Thomas Sailer wrote:
> Any news about the ptrace single-stepping breakage of wine?

I can't see if he CCd anybody from the archives but Jesse Allen posted a
nice analysis of the remaining problem here:

http://www.winehq.org/hypermail/wine-devel/2004/12/0691.html

Here is one interesting portion of his email:

> #3 signal.c - Clearing the trap flag if being traced by debugger in
> setup_sigcontext()
> 
> For some reason, Warcraft III doesn't work if it is cleared here.  I
> have no idea if this TF clear is really necessary.  However,
> everything I've read on this seems to indicate to me that this change
> is important, so I need to find out what this causes to the game.

The other changes Linus made are apparently good and do not cause
Warcraft to regress.

thanks -mike


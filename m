Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVAMFV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVAMFV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVAMFV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:21:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261151AbVAMFVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:21:21 -0500
Date: Thu, 13 Jan 2005 00:19:33 -0500
From: Dave Jones <davej@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113051933.GC7520@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	marcelo.tosatti@cyclades.com, greg@kroah.com, chrisw@osdl.org,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <20050113044919.GH14443@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113044919.GH14443@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:49:19PM -0800, William Lee Irwin III wrote:

 > On Wed, Jan 12, 2005 at 10:35:42PM -0500, Dave Jones wrote:
 > > The problem is it depends on who you are, and what you're doing with Linux
 > > how much these things affect you.
 > > A local DoS doesn't both me one squat personally, as I'm the only
 > > user of computers I use each day. An admin of a shell server or
 > > the like however would likely see this in a different light.
 > > (though it can be argued a mallet to the kneecaps of the user
 > >  responsible is more effective than any software update)
 > 
 > It deeply disturbs me to hear this kind of talk. If we're pretending to
 > be a single-user operating system, why on earth did we use UNIX as a
 > precedent in the first place?

You completely missed my point. What's classed as a threat to one
user just isn't relevant to another.

 > On Wed, Jan 12, 2005 at 10:35:42PM -0500, Dave Jones wrote:
 > > An information leak from kernel space may be equally as mundane to some,
 > > though terrifying to some admins. Would you want some process to be
 > > leaking your root password, credit card #, etc to some other users process ?
 > > priveledge escalation is clearly the number one threat. Whilst some
 > > class 'remote root hole' higher risk than 'local root hole', far
 > > too often, we've had instances where execution of shellcode by
 > > overflowing some buffer in $crappyapp has led to a shell
 > > turning a local root into a remote root.
 > > For us thankfully, exec-shield has trapped quite a few remotely
 > > exploitable holes, preventing the above.
 > 
 > If we give up and say we're never going to make multiuser use secure,
 > where is our distinction from other inherently insecure single-user OS's?
 
Nowhere did I make that claim.  If you parsed the comment about
exec-shield incorrectly, I should point out that we also issued
security updates to various applications even though (due to exec-shield)
our users weren't vulnerable.  The comment was an indication that
the extra barrier has bought us some time in preparing updates
when 0-day exploits have been sprung on us unexpectedly on more
than one occasion.

		Dave


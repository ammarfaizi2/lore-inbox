Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbULALsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbULALsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 06:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbULALsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 06:48:07 -0500
Received: from p508B7F35.dip.t-dialin.net ([80.139.127.53]:54656 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261376AbULALsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 06:48:02 -0500
Date: Wed, 1 Dec 2004 12:46:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041201114622.GB4876@linux-mips.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <1101721336.21273.6138.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101721336.21273.6138.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 09:42:16AM +0000, David Woodhouse wrote:

> I've lost track of the number of times things have broken because of
> incorrect use of kernel headers from userspace. That's what we're trying
> to fix -- by putting only the bits which are _supposed_ to be visible
> into files which userspace sees, where we know they define part of the
> userspace API and hence we can be extremely careful when editing them. 
> 
> I don't think it makes sense at this point for us to bury our collective
> heads in the sand and pretend there isn't a problem here that's worth
> fixing.
> 
> I agree that it should be obviously correct though -- and that's why
> we're trying to end up with a structure that in the first pass would
> give us in userspace essentially what we already have in the various
> glibc-kernheaders packages, but without the constant and unnecessary
> need for some poor sod to keep those up to date by hand.

The concept of copying kernel headers into applications is even worse
when arch portability is affected.  I stopped counting how often I had
to fix that kind of crap - and the state of kernel headers and userspace
kernel header packages is really provoking that kind of mess.

  Ralf

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUK3Q3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUK3Q3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbUK3Q3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:29:52 -0500
Received: from canuck.infradead.org ([205.233.218.70]:29190 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262176AbUK3Q3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:29:45 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <1101828924.26071.172.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1101832116.26071.236.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 16:28:36 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 07:58 -0800, Linus Torvalds wrote:
> The fact is, despite this stupid and way-too-long thread, #ifdef 
> __KERNEL__ has worked for over a decade, and works damn well, everything 
> considered. 

I don't agree with that. The current setup is a complete PITA and that's
why people are clamouring for us to clean the crap up.

But if you feel this strongly about it, then let's go ahead with the
existing mess. We can add more ifdef __KERNEL__ and add rules to the
makefiles to export it for userspace, generating something like the
existing glibc-kernheaders setup. And of course we can look at the
better alternative 'annotations' instead of using #ifdef __KERNEL__.

I think we'll all hate it, and I don't think it's going to really fix
the problem. But we can always reconsider the position later.

> Same thing here. The __KERNEL__ approach says "whatever you want, boss".  
> It doesn't get in the way. Maybe it doesn't actively _help_ you either,
> but you never have to fight any structure it imposes on you.

Having to think before adding something that's user visible is a
_benefit_ not a disadvantage.

-- 
dwmw2


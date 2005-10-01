Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVJAUq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVJAUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVJAUq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 16:46:57 -0400
Received: from pop.gmx.de ([213.165.64.20]:10184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750842AbVJAUq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 16:46:57 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] usb/core/hcd-pci.c: don't free_irq() on suspend
Date: Sat, 1 Oct 2005 22:46:56 +0200
User-Agent: KMail/1.7.2
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, rjw@sisk.pl, akpm@osdl.org,
       Linus Torvalds <torvalds@osdl.org>
References: <200509302101.j8UL1Htj026067@hera.kernel.org> <20050930233833.GA19471@kroah.com>
In-Reply-To: <20050930233833.GA19471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510012246.57783.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ restored some of the cc: list of the original thread ]

On Saturday 01 October 2005 01.38, Greg KH wrote:
> <top-post on purpose...>
> 
> Daniel, are you sure about this patch (the second part specifically)?

well, the first hunk doesn't make sense without the second and vice versa,
isn't it? to answer your question: yes.

> It directly conflicts with a set of patches in my current tree in this
> area that fix all of the reported suspend/resume issues with usb host
> controllers (that patch series written by David Brownell.)
> 
> Yeah, I see that we shouldn't have been dropping the irq on suspend and
> getting a new one on resume, that's not good and could have caused
> problems for people.
> 
> But could you at least drop the linux-usb-devel mailing list a note that
> you are having issues, and post the proposed patch?  Directly sending it

i don't have problems, it was rafael...i just happend to look at it because
yenta_socket was involved...see the following link for more background:
	http://marc.theaimsgroup.com/?t=112275164900002&r=1&w=4

> to Linus is a bit rude, it's not like the USB developers aren't

sorry for that, but i actually asked for a round in -mm. it just happend
that linus was on to: and the rest on cc: by pressing reply-to-all in kmail

the original thread
	http://marc.theaimsgroup.com/?t=112618280600003&r=1&w=4

> responsive to emails (yeah, I've been a bit slow at times these past few
> weeks, but my traveling all over the place for the past month is now
> over, and I'm not going anywhere for a long time...)
> 
> David, this conflicts with your usb/usb-pm-06.patch in my quilt tree.
> I'll try to resolve the merge with my best guess, but you should check
> that I got it right...
> 
> thanks,
> 
> greg k-h
> 

rgds
-daniel

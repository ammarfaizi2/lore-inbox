Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbUJ1R2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUJ1R2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUJ1R2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:28:47 -0400
Received: from THUNK.ORG ([69.25.196.29]:24521 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262070AbUJ1R2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:28:00 -0400
Date: Thu, 28 Oct 2004 13:27:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: michael@optusnet.com.au,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041028172731.GB8220@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Richard Moser <nigelenki@comcast.net>, michael@optusnet.com.au,
	"Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
	Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
	'Chuck Ebbert' <76306.1226@compuserve.com>,
	'Bill Davidsen' <davidsen@tmr.com>,
	'William Lee Irwin III' <wli@holomorphy.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin> <200410261719.56474.edt@aei.ca> <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <417F315A.9060906@comcast.net> <m1sm7znxul.fsf@mo.optusnet.com.au> <41811AF2.2000503@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41811AF2.2000503@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 12:14:42PM -0400, John Richard Moser wrote:
> I've already heard rumors (very few, and they've been squashed) of
> GrSecurity being abandoned.  The authors of both PaX and Gr are both
> active, they're just spinning on 2.6.7.
> 
> Do you see the scenario occuring here?  Their project is obviously
> inferior in many peoples' minds because it's not the latest
> hot-off-the-LKML 2.6 kernel.  Indeed, many security fixes in (soon to
> be) 2.6.10 aren't in 2.6.7, which could provide known ways to easily
> slip straight past PaX and Gr (I haven't done my research, but this is
> not a hollow scenario).

So the security people who are doing the security patches have two
choices.

(a) Keep up with the mainline kernel, and try to get their changes
merged into the mainline kernel.

(b) Backport the security patches into 2.6.7, or convince/pay someone
to do this work for them.  

Well, I suppose the incessant whining on LKML might be considered an
ineffective way of trying to do (b), but fundamentally, it doesn't
address the this important question: Why should the mainline kernel
folks be asked to do extra work because the security people don't
want/care to get their code clean enough to be merged into mainline?

If they choose not to work towards merging their changes with
mainline, then they have to pay the price of an external patch, which
is constantly keeping up with a changing mainline, or creating their
own set of patch backports.  

I'll note by the way that the distributions have chosen the latter for
their stable Enterprise kernels; so this is an honorable and viable
choice, although they do have paying customers to allow them to pay
the costs of doing the backporting, testing, and qualifying the
patches to their stable snapshot for Red Hat's RHEL and SuSE's SLES.
The difference seems to be that you don't want to pay for a supported
distribution's stable kernel, and you don't want to do the work
yourself.  Instead you want to whine on LKML.  Is that a fair summary
of the state of affairs?

						- Ted

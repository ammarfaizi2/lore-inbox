Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVFPOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVFPOho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFPOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 10:37:44 -0400
Received: from thunk.org ([69.25.196.29]:23205 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261397AbVFPOhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 10:37:37 -0400
Date: Thu, 16 Jun 2005 10:37:27 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Message-ID: <20050616143727.GC10969@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Patrick McFarland <pmcfarland@downeast.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alexey Zaytsev <alexey.zaytsev@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f192987705061303383f77c10c@mail.gmail.com> <f192987705061310202e2d9309@mail.gmail.com> <1118690448.13770.12.camel@localhost.localdomain> <200506152149.06367.pmcfarland@downeast.net> <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y89a7wfn.fsf@jbms.ath.cx>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 12:33:16AM -0400, Jeremy Maitin-Shepard wrote:
> > Ext2/3's encoding has always been utf-8.  Period.
> 
> In what way does Ext2/3 know or care about file name encoding?  Doesn't
> it just store an arbitrary 8-byte string?  Couldn't someone claim that
> from the start it was designed to use iso8859-1 just as easily as you
> can claim it was designed to use utf-8?

Because we've had this discussion^H^H^H^H^H^H^H^H^H^H^H flame war
years ago, and despite people from Russia whining that that it took 3
bytes to encode each Cyrillic character in UTF-8, it's where we came out.  

The bottom-line though is that if someone files a bug report with ext3
because one user on the system was is creating filenames in Japanese,
and another user on the same time-sharing system is creating filenames
in Germany, and they fail to interoperate, and they were doing so in
their local language, we would laugh at them --- just as people
writing mail programs would laugh at people who complained that they
were running into problems Just Sending 8-bits instead of using MIME,
and could you please fix this business-critical bug?  

Or as more and more desktop programs start interpreting the filenames
as UTF-8, and people with local variations get screwed, that is their
problem, and Not Ours.

So no, we can't prevent anyone from shooting them in the foot.
However, if they *do* take the gun, aim it straight downwards, and
pull the trigger, we aren't obligated to help.

						- Ted

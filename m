Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUHVRDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUHVRDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268030AbUHVRDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:03:07 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37611 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268029AbUHVRDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:03:02 -0400
Subject: Re: [PATCH] ppc32 use simplified mmenonics
From: Albert Cahalan <albert@users.sf.net>
To: Vincent Hanquez <tab@snarc.org>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040822162845.GA10911@snarc.org>
References: <1093135526.5759.2513.camel@cube>
	 <20040822094317.GA2589@snarc.org> <1093171291.5759.2544.camel@cube>
	 <20040822144501.GA10017@snarc.org> <1093178422.2301.2674.camel@cube>
	 <20040822162845.GA10911@snarc.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093184939.2301.2799.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Aug 2004 10:29:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-22 at 12:28, Vincent Hanquez wrote:

> However each person that has read some documentations about ppc assembly know
> that a 'clrrwi' is a macro to a more complex instruction 'rlwinm'.
> 
> Any documentation that wouldn't mention that is just plain wrong.

It's buried in Appendix F.

> > OK, that's 8. Dividing 456 by that, I still see a 57:1 ratio.
> > 
> > There's also that matter of the 1848 operations you can't
> > access via the "simplified" instruction names.
> 
> Are you counting one operations for 'rlwinm' and one for 'rlwinm.' to have
> so much (1848) operations ? or is your figures totally random ?

That's just for branches.

There are 32 condition register bits.
There are 9 values for the BO field. (so far)
There are 8 of these: bc,bca,bcl,bcla,bcctr,bcctrl,bclr,bclrl

That comes to 2304. Subtract the 456 "simplified"
instruction names you have. That leaves 1848 that
you are unable to access.

Take a look at the crand instruction. It uses numbers.
Now, just imagine mixing that with branch instructions
that hide the numbers. I hope you see the problem.

> But anyway it seems, we could discuss the benefit or not, of using simplified
> instructions the whole night. I think this is a good idea (obviously) and it
> seems Benjamin thinks it too. Thoses simplified instructions are mentioned in
> all officials ppc assembly documentation because they are simple and help.

It doesn't appear to be so. He wrote:

: Oh well.. I've got quite used to tweaking rlwinm directly
: but I suppose it's more clear for others to go to clrrwi.

So I'd like him to know that others like rlwinm directly too.
Using instructions that are in the index makes sense.
Using a zillion poorly documented alternatives is madness.



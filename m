Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVCEKoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVCEKoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 05:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVCEKon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 05:44:43 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:22035 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262469AbVCEKnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 05:43:08 -0500
Date: Sat, 5 Mar 2005 11:43:05 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050305104305.GB7671@pclin040.win.tue.nl>
References: <20050304222146.GA1686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304222146.GA1686@kroah.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : pastinakel.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:

> Anything else anyone can think of?  Any objections to any of these?
> I based them off of Linus's original list.
> 
> thanks,
> 
> greg k-h
> 
> ------
> 
> Rules on what kind of patches are accepted, and what ones are not, into
> the "linux-release" tree.
> 
>  - It can not bigger than 100 lines, with context.
>  - It must fix only one thing.
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing.)
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
>  - No "theoretical race condition" issues, unless an explanation of how
>    the race can be exploited.
>  - It can not contain any "trivial" fixes in it (spelling changes,
>    whitespace cleanups, etc.)

Objections - no. Anything else - yes.
I would like the requirement: "It must be obviously correct".

In a hundred lines one can put a lot of tricky code and subtle changes.
For example, if a security problem necessitates a nontrivial change,
it should cause an earlier release of 2.6.x+1 instead of a 2.6.x.y+1.

Andries

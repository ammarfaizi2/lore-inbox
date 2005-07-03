Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVGCS33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVGCS33 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 14:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGCS33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 14:29:29 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:12756 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S261486AbVGCS30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 14:29:26 -0400
Date: Sun, 3 Jul 2005 11:25:05 -0700
From: Tony Jones <tonyj@suse.de>
To: serge@hallyn.com
Cc: Greg KH <greg@kroah.com>, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050703182505.GA29491@immunix.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050701203526.GA824@kroah.com> <20050703002441.GA25052@vino.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703002441.GA25052@vino.hallyn.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 07:24:41PM -0500, serge@hallyn.com wrote:
> Hmm, I could instead have one file per loaded LSM, which could
> obviate the need for the stacker/unload file, but that would make
> it more work for a user to find the ordering of the LSMs.  I wonder
> how much that would matter.
> 
> I'll implement your other changes, and consider switching to a
> stackerfs (versus changing the content presentation under sysfs).

I'd prefer each file (per loaded LSM) when read returned it's ordering
position, even though it's much clumsier than your current implementation.

There just isn't enough content to justify a stacker specific filesystem IMHO.

Tony

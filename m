Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268674AbUIHFZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268674AbUIHFZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 01:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUIHFZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 01:25:38 -0400
Received: from agp.Stanford.EDU ([171.67.73.10]:29056 "EHLO agp.stanford.edu")
	by vger.kernel.org with ESMTP id S268674AbUIHFZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 01:25:27 -0400
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200409080510.i885ANcX025884@csl.stanford.edu>
Subject: Re: [CHECKER] possible reiserfs deadlock in 2.6.8.1
To: viro@parcelfarce.linux.theplanet.co.uk
Date: Tue, 7 Sep 2004 22:10:23 -0700 (PDT)
Cc: engler@coverity.dreamhost.com (Dawson Engler),
       linux-kernel@vger.kernel.org, developers@coverity.com
Reply-To: engler@csl.stanford.edu
In-Reply-To: <20040908033628.GV23987@parcelfarce.linux.theplanet.co.uk> from "viro@parcelfarce.linux.theplanet.co.uk" at Sep 08, 2004 04:36:28 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scan-Signature: 6c9d9c85a593a9550db5337c65f4967d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Sep 07, 2004 at 08:16:53PM -0700, Dawson Engler wrote:
> > Hi All,
> > 
> > below is a possible deadlock in the linux-2.6.8.1 reiserfs code found by
> > a static deadlock checker I'm writing.  Let me know if it looks valid
> > and/or whether the output is too cryptic.    Note, one of the locks is
> > through a struct pointer, so the deadlock depends on both acquisitions
> > being to the same struct.
> 
> Not valid, for the same reason as the above.  BKL and down() do not form
> a mutual deadlock.

You know, I actually know this, and the tool "does" take care of this.
I think a bit mask got screwed up somewhere.  Along with my brain...

Sorry about the noise.

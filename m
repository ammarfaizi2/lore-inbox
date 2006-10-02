Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWJBLJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJBLJH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWJBLJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:09:07 -0400
Received: from [213.46.243.16] ([213.46.243.16]:28233 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750764AbWJBLJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:09:06 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: ashwin.chaugule@celunite.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <1159786807.5574.14.camel@localhost.localdomain>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org>  <1159774552.13651.80.camel@lappy>
	 <1159786807.5574.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 13:08:45 +0200
Message-Id: <1159787325.28131.144.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 16:30 +0530, Ashwin Chaugule wrote:
> On Mon, 2006-10-02 at 09:35 +0200, Peter Zijlstra wrote:

> > So while I agree it would be nice to get rid of all magic variables
> > (holding time in the current impl) this proposed solution hasn't
> > convinced me (for one it introduces another).
> > 
> > (for the interrested, the various attempts I tried are available here:
> >   http://programming.kicks-ass.net/kernel-patches/swap_token/ )
> 
> Cool!
> 
> Had you applied these patches when you posted your test results ?

Only my test box ever ran them.

They are replacements for your 2nd patch, timings I got from them were
worse than with yours though, needs more attention.

A variation on 3 I have in mind is to reset the prio of the loosing mm
to 0 - this should avoid it regaining the token quickly.


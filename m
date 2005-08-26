Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVHZSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVHZSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbVHZSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:07:57 -0400
Received: from cerebus.immunix.com ([198.145.28.33]:2468 "EHLO
	ermintrude.int.immunix.com") by vger.kernel.org with ESMTP
	id S965157AbVHZSH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:07:56 -0400
Date: Fri, 26 Aug 2005 11:03:39 -0700
From: Tony Jones <tonyj@immunix.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Tony Jones <tonyj@suse.de>, Kurt Garloff <garloff@suse.de>,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Rework stubs in security.h
Message-ID: <20050826180339.GA2512@immunix.com>
References: <20050825012028.720597000@localhost.localdomain> <20050825012148.690615000@localhost.localdomain> <20050826173151.GA1350@immunix.com> <20050826175952.GP7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826175952.GP7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 10:59:52AM -0700, Chris Wright wrote:
> * Tony Jones (tonyj@suse.de) wrote:
> > The discussion about composing with commoncap made me think about whether
> > this is the best way to do this.   It seems that we're heading towards a
> > requirement that every module internally compose with commoncap.  
> 
> Not a requirement, it's a choice ATM.

Can you think of a case where the choice (on the part of the module author)
to not do so makes any sense?

> Heh, this was next on my list.  I just wanted to separate the changes to
> one at a time so we can easily measure the impact.  This becomes another
> policy shift.

I understand the advantages of clearly measuring the impact of each change
independantly but with SELinux having to change how they use their secondaries 
at the same time, I'm not sure there is a lot of difference between the 
two phases.

> > If every module is already internally composing, there shouldn't be a 
> > performance cost for the additional branch inside the #ifdef.
> 
> This needs measurement to verify.

Agreed.  So does the current proposal :-)

Tony

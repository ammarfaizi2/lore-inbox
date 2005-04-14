Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVDNApR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVDNApR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVDNApQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:45:16 -0400
Received: from waste.org ([216.27.176.166]:2726 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261412AbVDNAo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:44:56 -0400
Date: Wed, 13 Apr 2005 17:44:35 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: Fortuna
Message-ID: <20050414004435.GJ3174@waste.org>
References: <20050413234337.GE12263@certainkey.com> <20050414000939.GH3174@waste.org> <20050414002647.GG12263@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414002647.GG12263@certainkey.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 08:26:47PM -0400, Jean-Luc Cooke wrote:
> On Wed, Apr 13, 2005 at 05:09:39PM -0700, Matt Mackall wrote:
> > On Wed, Apr 13, 2005 at 07:43:37PM -0400, Jean-Luc Cooke wrote:
> > > Ahh.  Thanks Herbert.
> > > 
> > > Matt,
> > > 
> > > Any insight on how to test syn cookies and the other network stuff in
> > > random.c?  My patch is attached, but I havn't tested that part yet.
> > 
> > For starters, this is not against anything like a current random.c. A
> > great number of cleanups have been done.
> 
> You caught me.  :)
> 
> Last I proposed Fortuna for /dev/random it nearly got me drawn and quarterd.

It still might. Ted and I are as yet unconvince that the Fortuna
approach is superior. While it may have some good properties, it lacks
some that random.c has, particularly robustness in the face of failure
of crypto primitives.

> So I've left it as a kenrel config option, leaving the current random.c
> alone.  I thought this was a way to make everyone happy.

Duplicated code rarely does that.

At any rate, you ought to review the changes (there've been 40+
patches recently). There are a number of bug fixes in there and quite
a bit of cleanup. Syncookies in particular no longer live in random.c.

-- 
Mathematics is the supreme nostalgia of our time.

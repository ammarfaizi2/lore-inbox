Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUA1WXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266222AbUA1WXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:23:34 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:16052 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S266217AbUA1WWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:22:36 -0500
Date: Wed, 28 Jan 2004 14:22:25 -0800
From: Tim Hockin <thockin@sun.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-ID: <20040128222225.GH9155@sun.com>
Reply-To: thockin@sun.com
References: <Pine.LNX.4.44.0401281757190.6213-100000@localhost.localdomain> <Pine.LNX.4.58.0401281007420.27790@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401281007420.27790@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:10:02AM -0800, Linus Torvalds wrote:
> Although I do believe that it would be better written as
> 
> 	#define MAXGROUPS (1000) /* Arbitrary, but we have to limit it somehere */
> 
> 	if ((unsigned) info->ngroups > MAXGROUPS)
> 		return -ETOOEFFINGLARGE;
> 
> as I absolutely _despise_ code that tries to be too generic. 
> 
> What is it with CS classes that have removed "common sense" from the 
> equation?

OK, there are two easy answers to this.  I can re-work it with a simple 32k
limit that needs to be recompiled to change, or I can add a sysctl to
control it (it appeared in an early version of this patch).

Preference?

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

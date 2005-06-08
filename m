Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVFHVUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVFHVUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVFHVUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:20:50 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:58353 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261373AbVFHVUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:20:44 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] capabilities not inherited
From: Alexander Nyberg <alexn@telia.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Manfred Georg <mgeorg@arl.wustl.edu>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050608204430.GC9153@shell0.pdx.osdl.net>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
	 <20050608204430.GC9153@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 23:20:42 +0200
Message-Id: <1118265642.969.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons 2005-06-08 klockan 13:44 -0700 skrev Chris Wright:
> * Manfred Georg (mgeorg@arl.wustl.edu) wrote:
> > I was working with passing capabilities through an exec and it
> > didn't do what I expected it to.  That is, if I set a bit in
> > the inherited capabilities, it is not "inherited" after an
> > exec().  After going through the code many times, and still not
> > understanding it, I hacked together this patch.  It probably
> > has unforseen side effects and there was probably some
> > reason it was not done in the first place.
> 
> True to both.  If you'd like to work with this, check the archives for
> similar patches.  Most recent in a thread from Alex Nyberg starting
> here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111062795600730&w=2
> 

btw since the last discussion was about not changing the existing
interface and thus exposing security flaws, what about introducing
another prctrl that says maybe PRCTRL_ACROSS_EXECVE?

Any new user-space applications must understand the implications of
using it so it's safe in that aspect. Yes?

(yeah it's rather silly since there already is an unused
keep_capabilities flag but that would change old interfaces so ok)


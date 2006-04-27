Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWD0LGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWD0LGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWD0LGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:06:19 -0400
Received: from ns.suse.de ([195.135.220.2]:40926 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932449AbWD0LGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:06:18 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Date: Thu, 27 Apr 2006 13:05:59 +0200
User-Agent: KMail/1.9.1
Cc: Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
References: <1145522524.3023.12.camel@laptopd505.fenrus.org> <17487.61698.879132.891619@cse.unsw.edu.au> <20060427110202.GA10481@infradead.org>
In-Reply-To: <20060427110202.GA10481@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271306.00313.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 13:02, Christoph Hellwig wrote:
> On Thu, Apr 27, 2006 at 08:15:30AM +1000, Neil Brown wrote:
> > 3/ Is AppArmour's approach of using d_path to get a filename from a
> >    dentry valid and acceptable?
> 
> Clear no, and that should have been obvious to the aa people from the
> beginning.  To make a path-based approach actually work as designed you
> need to hook up higher, where the real path is available. 

What do you mean with real path? Even in open the path can be quite weird
("dir1/../dir2/../dir3/..." etc.)

I suspect it will always need to work with sanitized paths.

Starting from the dentry for that is a quite reasonable, although
d_path indeed seems quite inefficient without any caching mechanism.

-Andi

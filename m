Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWD0LCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWD0LCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWD0LCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:02:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46824 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932428AbWD0LCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:02:10 -0400
Date: Thu, 27 Apr 2006 12:02:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Neil Brown <neilb@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060427110202.GA10481@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Neil Brown <neilb@suse.de>, Stephen Smalley <sds@tycho.nsa.gov>,
	Chris Wright <chrisw@sous-sol.org>,
	James Morris <jmorris@namei.org>,
	Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil> <20060421173008.GB3061@sorel.sous-sol.org> <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil> <17484.20906.122444.964025@cse.unsw.edu.au> <1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil> <17485.55676.177514.848509@cse.unsw.edu.au> <1145984831.21399.74.camel@moss-spartans.epoch.ncsc.mil> <17487.61698.879132.891619@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17487.61698.879132.891619@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 08:15:30AM +1000, Neil Brown wrote:
> 3/ Is AppArmour's approach of using d_path to get a filename from a
>    dentry valid and acceptable?

Clear no, and that should have been obvious to the aa people from the
beginning.  To make a path-based approach actually work as designed you
need to hook up higher, where the real path is available. 

>    If not, how can it get a path?  Can
>    suitable hooks be provided so that AppArmor can get a path in an
>    acceptable way at the times when that is meaningful?

I think that's up to the aa people to find out.


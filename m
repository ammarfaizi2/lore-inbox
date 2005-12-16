Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVLPRF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVLPRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVLPRF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 12:05:58 -0500
Received: from mail.shareable.org ([81.29.64.88]:18878 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1750715AbVLPRF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 12:05:58 -0500
Date: Fri, 16 Dec 2005 17:00:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: JANAK DESAI <janak@us.ibm.com>, viro@ftp.linux.org.uk, chrisw@osdl.org,
       dwmw2@infradead.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler function
Message-ID: <20051216170021.GA12495@mail.shareable.org>
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com> <m1k6e687e2.fsf@ebiederm.dsl.xmission.com> <43A1D435.5060602@us.ibm.com> <m1d5jy83nr.fsf@ebiederm.dsl.xmission.com> <43A24362.6000602@us.ibm.com> <20051216105048.GA32305@mail.shareable.org> <m1wti56wgw.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wti56wgw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > Like clone(), unshare() will have to change from year to year, as new
> > flags are added.  It would be good if the default behaviour of 0 bits
> > to unshare() also did the right thing, so that programs compiled in
> > 2006 still function as expected in 2010.  Hmm, this
> > forward-compatibility does not look pretty.
> 
> Why all it requires is that whenever someone updates clone they update
> unshare.  Given the tiniest bit of refactoring we should be
> able to share all of the interesting code paths.

That only works if unshare() should always mean "unshare everything
except specified things", including things that we currently don't
unshare.

I guess that is probably fine.  Anything that would break
unshare()-using programs in future if it unshared by default, would be
likely to break clone()-using programs too.  Is that right?  Any
counterexamples?

-- Jamie

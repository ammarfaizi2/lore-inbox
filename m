Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUG2P5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUG2P5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUG2P40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:56:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22715 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267454AbUG2PxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:53:09 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       jbarnes@engr.sgi.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<20040728164457.732c2f1d.akpm@osdl.org>
	<133880000.1091110104@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2004 09:52:17 -0600
In-Reply-To: <133880000.1091110104@[10.10.2.4]>
Message-ID: <m1vfg6kdzi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > We really want to get into the new kernel ASAP and clean stuff up from
> > in there.
> 
> As long as the "init" routines are run on every startup (not just kexec ones),
> they should get plenty of testing (though not from bad card state).

And I know for a fact that many init routines won't initialize a
card in a bad state currently.  That is my most frequent failure in
the normal kexec case, when things are not in a 
 
> I still think we could share code by running the shutdown routines from 
> the *new* kernel  before trying to init the card if they're written in a 
> robust way so as to allow it ... is that insane?

As a rough feel yes that is sane.  Redundant but sane.  I would
like to hear what greg thinks of it though.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUG1U3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUG1U3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUG1U3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:29:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18104 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263024AbUG1U3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:29:01 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org, Hariprasad Nellitheertha <hari@in.ibm.com>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 14:28:08 -0600
In-Reply-To: <25870000.1091042619@flay>
Message-ID: <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:
> We discussed this at kernel summit a bit - it'd be safer to make the devices
> clear down on boot up, rather than shutdown, if possible ... less work to
> do on the unstable base.

Agreed, but I think for starters we should capture the low hanging fruit
by calling the shutdown method and then increasingly harden the
code by performing less in the kernel that panics and more in the
cleanup kernel.

That way we can concentrate first on the interfaces to the rest of the
kernel.  And then we can make the solution bullet proof.

> Maybe we could shut down the devices on bringup, then bring it up again 
> (no I'm not kidding ;-)) ... should reuse the code.

Might not be a bad idea.

Eric

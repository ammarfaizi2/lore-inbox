Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267307AbUG1XXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267307AbUG1XXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUG1XUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:20:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42680 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267184AbUG1XSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:18:39 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 17:17:47 -0600
In-Reply-To: <1091044742.31698.3.camel@localhost.localdomain>
Message-ID: <m1llh367s4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mer, 2004-07-28 at 21:33, Andrew Morton wrote:
> > We really don't want to be calling driver shutdown functions from a crashed
> > kernel.
> 
> Then at the very least you need to disable bus mastering and have
> specialist recovery functions for problematic devices. The bus
> mastering one is essential otherwise bus masters will continue to
> DMA random data into your new universe.
> 
> Other stuff like graphics cards and IDE may need care too.

Alan if we call anything the shutdown methods really are the thing
to call.  Because they are exactly the specialty recovery functions for
problematic devices.

Of course no matter what we do will this work 100% of the time because
part of what we will be fighting is broken hardware.  However we should
be able to get a mechanism that works most of the time.

What is your concern with stopping DMA?
- Not smashing the recovery routine.
- Getting a corrupted core dump because of on-going DMA?

Eric

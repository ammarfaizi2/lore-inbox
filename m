Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUBFJdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUBFJdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:33:38 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:5274 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S265346AbUBFJdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:33:02 -0500
Message-ID: <40235E24.2060500@redhat.com>
Date: Fri, 06 Feb 2004 01:28:04 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Jamie Lokier <jamie@shareable.org>, Chris McDermott <lcm@us.ibm.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [RFC][PATCH] linux-2.6.2_vsyscall-gtod_B2.patch
References: <1076037045.757.21.camel@cog.beaverton.ibm.com> <20040206040123.GN31926@dualathlon.random>
In-Reply-To: <20040206040123.GN31926@dualathlon.random>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> with regards to Ulrich's security related comments, this won't make any
> difference compared to the fixed address version either, since the
> vsyscall page is still at a fixed address in the fixmap area,

Gee, you don't want to understand it.

Even if the official kernel's handling of the vdso puts it at the same
address all the time this does not mean this can be engraved in stone.
It must be possible to move the page.  And I expect this will be the
case in our kernels.

It is completely unacceptable to use fixed addresses or require the libc
to be recompiled for a new address.  At the highest security level the
vdso address should vary from program run to program run which means
there is no way to change the libc.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

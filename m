Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUG1P44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUG1P44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUG1Pza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:55:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43191 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267250AbUG1PyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:54:01 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: suparna@in.ibm.com, Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<20040728105455.GA11282@in.ibm.com>
	<m1k6wo17za.fsf@ebiederm.dsl.xmission.com>
	<120540000.1091028208@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2004 09:53:21 -0600
In-Reply-To: <120540000.1091028208@[10.10.2.4]>
Message-ID: <m1acxk1632.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> /dev/mem expects mem_map to be there, the size of which would easily
> blow away the reserved section. /dev/oldmem (or whatever we call it)
> is just a magic copy that does a kmap-like operation to get at pages
> without a struct page.

Don't we already do that for the mmap case so we can access I/O devices?

But I agree if there is a dependence there having a /dev/rawmem
thing that does not need a page struct would make sense.  I just
don't think we actually need it...

Eric


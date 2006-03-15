Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWCOVew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWCOVew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWCOVev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:34:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46551 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751520AbWCOVes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:34:48 -0500
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 16/24] i386 Vmi io header
References: <200603131811.k2DIBS8j005741@zach-dev.vmware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 14:17:32 -0700
In-Reply-To: <200603131811.k2DIBS8j005741@zach-dev.vmware.com> (Zachary
 Amsden's message of "Mon, 13 Mar 2006 10:11:28 -0800")
Message-ID: <m1acbrxv9v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> Move I/O instruction building to the sub-arch layer.  Some very crafty
> but esoteric macros are used here to get optimized native instructions
> for port I/O in Linux be writing raw instruction strings.  Adding a
> wrapper layer here is fairly easy, and makes the full range of I/O
> instructions available to the VMI interface.
>
> Also, slowing down I/O is not a useful operation in a VM, so there
> is a VMI call specifically to allow making it a NOP.  I could find
> no place where SLOW_IO_BY_JUMPING is still used, and consider it
> obsoleted.  Even on older 386 systems, the I/O delay approximation
> by touching the extra page register is likely to better.

This sounds like a prime candidate for the alternate instruction interfaces
and I don't see that being used here.

Eric

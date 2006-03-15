Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWCOWwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWCOWwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWCOWwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:52:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10150 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932552AbWCOWwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:52:37 -0500
Date: Wed, 15 Mar 2006 23:52:12 +0100
From: Pavel Machek <pavel@ucw.cz>
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
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 4/24] i386 Vmi inline implementation
Message-ID: <20060315225212.GB1719@elf.ucw.cz>
References: <200603131802.k2DI22OK005657@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131802.k2DI22OK005657@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 10:02:02, Zachary Amsden wrote:
> Macros to use VMI calls from assembly and C languages are introduced.
> The macros are quite complex, but the end result is rather impressive.
> The result is that when compiling a VMI kernel, the native code is
> emitted inline, with no function call overhead, and some wiggle room
> for register allocation.  The hypervisor compatibility code is emitted
> out of line into a separate section, and patched dynamically during the
> process of preparing the kernel for boot.  In the end, this task is
> envisioned as being done by a loader agent outside of the kernel proper,
> allowing for a completely transparent kernel start of day.

We already do runtime patching for SMP vs. UP, could you use same
infrastructure? I do not want VMI-specific grub.
								Pavel

-- 
42:             i < SampleTable.Length;

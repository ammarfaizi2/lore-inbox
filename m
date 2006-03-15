Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWCOJZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWCOJZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWCOJZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:25:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:56000 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932157AbWCOJZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:25:50 -0500
Message-ID: <4417DDF3.4060601@suse.de>
Date: Wed, 15 Mar 2006 10:27:15 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 7/24] i386 Vmi memory hole
References: <200603131804.k2DI4N6s005678@zach-dev.vmware.com> <20060314064107.GK12807@sorel.sous-sol.org> <44166D6B.4090701@vmware.com> <20060314215616.GM12807@sorel.sous-sol.org> <4417454F.2080908@vmware.com> <20060315043108.GP12807@sorel.sous-sol.org> <4417CFDA.1060806@suse.de> <4417D212.20401@vmware.com>
In-Reply-To: <4417D212.20401@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>        pushl $SYSENTER_RETURN
> 
> SYSENTER_RETURN is a link time constant that is defined based on the
> location of the vsyscall page.  If the vsyscall page can move, this can
> not be a constant.

The vsyscall page is at PAGE_OFFSET - 2*PAGE_SIZE.  It doesn't move.  At
least not at runtime.  At compile time it can change with the new
VMSPLIT config options, but that isn't a problem ;)

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg

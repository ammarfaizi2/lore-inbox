Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWCWAGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWCWAGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWCWAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:06:31 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:54283 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964884AbWCWAGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:06:11 -0500
Message-ID: <4421E672.3040803@vmware.com>
Date: Wed, 22 Mar 2006 16:06:10 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC, PATCH 1/24] i386 Vmi documentation
References: <200603131759.k2DHxeep005627@zach-dev.vmware.com> <200603222105.58912.ak@suse.de> <20060322213435.GI15997@sorel.sous-sol.org> <200603222213.45910.ak@suse.de>
In-Reply-To: <200603222213.45910.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Even then it's useless for many flags because any user program can (and will) 
> call CPUID directly. 

Turns out not to matter, since userspace can only make use of 
capabilities that are already available to userspace.  If the feature 
bits for system features are visible to it, it doesn't really matter.  
Yes, this could be broken in some cases.  But it turns out to be safe.  
Even sysenter support, which userspace does care about, is done via 
setting the vsyscall page up in the kernel, rather than userspace CPUID 
detection.

> Sure the point was if they write this long fancy document why stop
> at documenting the last 5%?
>   

Because the last 5% is what is changing to meet Xen's needs.  Why 
document something that you know you are going to break in a week?  I 
chose to document the stable interfaces first.

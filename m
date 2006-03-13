Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWCMSWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWCMSWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWCMSWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:22:18 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4879 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932318AbWCMSWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:22:17 -0500
Message-ID: <4415B857.9010902@vmware.com>
Date: Mon, 13 Mar 2006 10:22:15 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
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
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface	proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org>
In-Reply-To: <1142273346.3023.38.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> Two final notes.  This is not an attempt to force a proprietary interface
>> into the Linux kernel.  This is an attempt to find a common interface
>> that can be used by many hypervisors by isolating hypervisor specific
>> idioms into a neutral layer.  This new layer is just what is claims to
>> be - a virtual machine interface, which allows hypervisor dependent code
>> to be abstracted in a way that benefits both Linux and hypervisor
>> development.
>>     
>
>
> such an interface should be defined with source visibility of both sides
> though. At least of one user. Can XEN or any of the other open
> hypervisors use this? What does it look like? And if not, why not,
> wouldn't that make VMA a VMwareInterface instead ? ;)
>   

Yes, Xen can use this interface, even without modification to Xen.  The 
interface was used successfully to run a VMI kernel on Xen 2.0.  As it 
stands now, the interface does need to change a bit to accomodate Xen 
3.0 - but it is possible to do.  Rather than wait until we have a 
working prototype of that, we thought the interface itself warrants 
discussion now.

> Why can't vmware use the Xen interface instead?
>   

We could.  But it is our opinion that the Xen interface is unnecessarily 
complicated, without a clean separation between the layer of interaction 
with the hypervisor and the kernel proper.  The interface we propose we 
believe is more powerful, and more conducive to performance 
optimizations while providing significant advantages - most 
specifically, a single binary image that is properly virtualizable on 
multiple hypervisors and capable of running on native hardware.

Zach

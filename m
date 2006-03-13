Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWCMSzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWCMSzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCMSzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:55:04 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59823 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S1750743AbWCMSzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:55:02 -0500
In-Reply-To: <1142275365.3023.44.camel@laptopd505.fenrus.org>
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <1142273346.3023.38.camel@laptopd505.fenrus.org> <4415B857.9010902@vmware.com> <1142274398.3023.40.camel@laptopd505.fenrus.org> <4415BA4F.3040307@vmware.com> <1142275365.3023.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93FDC403-B5ED-4508-A468-1DE80D1CAB13@ira.uka.de>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Content-Transfer-Encoding: 7bit
From: Joshua LeVasseur <jtl@ira.uka.de>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization	interface	proposal
Date: Mon, 13 Mar 2006 19:56:04 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.2)
X-Spam-Score: -4.3 (----)
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Mar 13, 2006, at 19:42, Arjan van de Ven wrote:
>
> On Mon, 2006-03-13 at 10:30 -0800, Zachary Amsden wrote:
>>  and gives hypervisors room to grow while maintaining
>> binary compatibility with already released kernels.
>
> that I buy for binary only hypervisors. But in an open source world  
> I'll
> buy this a LOT less as being relevant.
>


Binary compatibility to Linux is pretty important for applications.   
Even though Apache is open source, I don't want to recompile it for  
every new Linux kernel.  Fortunately I don't have to, because glibc  
abstracts the Linux kernel interface.  Consider VMI in the same role  
as glibc -- when the hypervisor changes, VMI maintains compatibility  
with your pre-existing infrastructure, while letting you have some of  
the benefits of the new hypervisor.  The upgrade and recompile game  
can quickly end in a stalemate when you have packages with  
conflicting dependencies (one package requires the old version, and  
the other package requires the new version).

Josh


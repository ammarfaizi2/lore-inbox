Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbUK2Eg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUK2Eg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 23:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbUK2Eg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 23:36:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261626AbUK2Egy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 23:36:54 -0500
Message-ID: <41AAA746.5000003@pobox.com>
Date: Sun, 28 Nov 2004 23:36:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> In short: having the kernel use the same names as user space is ACTIVELY 
> BAD, exactly because those names have standards-defined visibility, which 
> means that the kernel _cannot_ use them in all places anyway. So don't 
> even _try_. 
> 
> On the bigger question of what to do with kernel headers in general, let's 
> just make one thing clear: the kernel headers are for the kernel, and big 
> and painful re-organizations that don't help _existing_ user space are not 
> going to happen.
> 
> In particular, any re-organization that breaks _existing_ uses is totally
> pointless. If you break existing uses, you might as well _not_ re-
> organize, since if you consider kernel headers to be purely kernel-
> internal (like they should be, but hey, reality trumps any wishes we might 
> have), then the current organization is perfectly fine.


I don't think any drastic reorganization is even necessary.

Mariusz Mazur <mmazur@kernel.pl> updates 
http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ for each 2.6.x 
kernel release.  linux-libc-headers are the kernel headers, with all the 
kernel-specific stuff stripped out.  i.e. userland ABI only.  Not sure 
how many distros have started picking that up yet...  I think Arjan said 
Fedora Core had, or would.

If people want to go beyond that, IMHO it would be simple and easy to 
start putting new kernel headers in include/kernel (or somesuch).  That 
way there are no massive reorganizations; kernel-specific stuff gets 
slowly migrated to a kernel-specific area.

	Jeff



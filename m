Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUK2KC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUK2KC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUK2KC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:02:28 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:5515 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261648AbUK2KCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:02:18 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <1101722231.2814.42.camel@laptop.fenrus.org>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <16810.61839.658951.369223@cargo.ozlabs.ibm.com>
	 <1101722231.2814.42.camel@laptop.fenrus.org>
Content-Type: text/plain
Message-Id: <1101722480.21273.6158.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 29 Nov 2004 10:01:20 +0000
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 10:57 +0100, Arjan van de Ven wrote:
> > I'd be interested to hear your take on this.  Should we try to make
> > our atomics easy and safe for userspace to use (including putting them
> > under the LGPL)?  Or can you see a better solution?
> 
> it's not the kernel's job to provide this functionality imo. 

Sometimes the functionality would have to be entirely reimplemented to
make it viable for userspace. For FR-V we set aside a condition register
for use in the kernel, so we can emulate ll/sc with multiple-issue
instructions. That can never work in userspace.

We can't just pretend there isn't a problem here.

-- 
dwmw2



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUK2E5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUK2E5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 23:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUK2E5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 23:57:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15563 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261627AbUK2E5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 23:57:09 -0500
Date: Mon, 29 Nov 2004 04:57:06 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041129045705.GM26051@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AAA746.5000003@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 11:36:22PM -0500, Jeff Garzik wrote:
> If people want to go beyond that, IMHO it would be simple and easy to 
> start putting new kernel headers in include/kernel (or somesuch).  That 
> way there are no massive reorganizations; kernel-specific stuff gets 
> slowly migrated to a kernel-specific area.

ITYM "to areas where it actually gets used".  A _lot_ in include/* is
used only by a couple of drivers and should've been sitting in
drivers/*/* instead.

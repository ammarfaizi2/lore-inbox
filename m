Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUK2F3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUK2F3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 00:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUK2F3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 00:29:24 -0500
Received: from [66.35.79.110] ([66.35.79.110]:63396 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261634AbUK2F3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 00:29:22 -0500
Date: Sun, 28 Nov 2004 21:27:33 -0800
From: Tim Hockin <thockin@hockin.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041129052733.GA29835@hockin.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com> <20041129045705.GM26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129045705.GM26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 04:57:06AM +0000, Al Viro wrote:
> ITYM "to areas where it actually gets used".  A _lot_ in include/* is
> used only by a couple of drivers and should've been sitting in
> drivers/*/* instead.

Amen to that!  Just because it is a header doesn't mean it belongs in
include.  Just because it is a #define or a struct definition does not
mean it belongs in a header.

So many people don't get the idea of exposed vs private interfaces.

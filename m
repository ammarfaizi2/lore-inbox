Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbULNQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbULNQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULNQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:56:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:51912 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261559AbULNQzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:55:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Werner Almesberger <wa@almesberger.net>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<20041214025110.A28617@almesberger.net>
	<Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: If our behavior is strict, we do not need fun!
Date: Tue, 14 Dec 2004 17:55:02 +0100
In-Reply-To: <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 14 Dec 2004 07:49:05 -0800 (PST)")
Message-ID: <jek6rkhlax.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> This is a common issue with namespace pollution. For example, this program 
> is perfectly valid afaik (well, except for being _stupid_, but that's 
> another issue):
>
> 	#include <stdio.h>
>
> 	const char *int32_t(int i)
> 	{
> 		return i ? "non-zero" : "zero";
> 	}

Actually this is not allowed in POSIX.  _Any_ header may define any
identifier ending with "_t".

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

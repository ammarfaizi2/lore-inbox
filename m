Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbULEENF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbULEENF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 23:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULEENF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 23:13:05 -0500
Received: from smtpout03-04.mesa1.secureserver.net ([64.202.165.74]:28103 "HELO
	smtpout03-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S261252AbULEENB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 23:13:01 -0500
Message-ID: <41B28946.5010904@starnetworks.us>
Date: Sat, 04 Dec 2004 21:06:30 -0700
From: "Kevin P. Fleming" <kpfleming@starnetworks.us>
Organization: Star Networks, LLC
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: Proposal for a userspace "architecture portability" library
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com> <1102214647.5520.133.camel@gaston>
In-Reply-To: <1102214647.5520.133.camel@gaston>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Interesting ... note also that it goes well with my intend of having
> some of these (atomics, locks, ...) be provided by the kernel via the
> vDSO library mapped by the kernel in userland on ppc. That library would
> abstract that nicely. (That way, the kernel can take care of providing
> the best implementation for a given processor, dealing with CPU errata
> that often happen around areas of locks & atomics, etc...)

Another thought... the Apache APR library already attempts to provide 
some of this functionality (atomic operations and locks, among others). 
This would fit nicely, as it would provide the underlying core for these 
operations, and allow APR to be extremely well optimized when built for 
a Linux platform.

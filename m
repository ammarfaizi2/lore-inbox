Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbULPBVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbULPBVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbULPBTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:19:30 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:20685 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262593AbULPA7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 19:59:14 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<20041214025110.A28617@almesberger.net>
	<Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org>
	<20041214135029.A1271@almesberger.net>
	<Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org>
	<20041214184605.B1271@almesberger.net>
	<m3fz28tp82.fsf@defiant.pm.waw.pl>
	<20041214210912.C1271@almesberger.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 16 Dec 2004 01:58:31 +0100
In-Reply-To: <20041214210912.C1271@almesberger.net> (Werner Almesberger's
 message of "Tue, 14 Dec 2004 21:09:12 -0300")
Message-ID: <m38y7zt5xk.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> That's not what should be happening there: if the kernel only uses
> __u32 and friends but never uint32_t et al. at an interface,
>
> typedef __u32 uint32_t;
>
> should be a perfectly safe thing for glibc's stdint.h to do.

Aaah, right. I thought about #define there, it would be the other way
around and thus wrong. Looks like I have to read my mail a bit earlier.
-- 
Krzysztof Halasa

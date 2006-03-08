Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWCHWhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWCHWhS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWCHWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:37:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58596 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751285AbWCHWhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:37:15 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>,
       David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@redhat.com, linuxppc64-dev@ozlabs.org
In-Reply-To: <17423.21837.304330.623519@cargo.ozlabs.ibm.com>
References: <1141756825.31814.75.camel@localhost.localdomain>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <9551.1141762147@warthog.cambridge.redhat.com>
	 <200603080925.19425.duncan.sands@math.u-psud.fr>
	 <17423.21837.304330.623519@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 22:42:29 +0000
Message-Id: <1141857749.10606.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-09 at 09:06 +1100, Paul Mackerras wrote:
> I'd be interested to know what the C standard says about whether the
> compiler can reorder writes that may be visible to a signal handler.
> An interrupt handler in the kernel is logically equivalent to a signal
> handler in normal C code.

The C standard doesn't have much to say. POSIX has a lot to say and yes
it can do this. You do need volatile or store barriers in signal touched
code quite often, or for that matter locks

POSIX/SuS also has stuff to say about what functions are signal safe and
what is not allowed.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUHXPNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUHXPNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHXPNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:13:49 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:2710 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S267958AbUHXPNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:13:46 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 24 Aug 2004 08:13:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] lazy TSS's I/O bitmap copy ...
In-Reply-To: <1093330271.2792.3.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0408240751270.4132@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0408231311460.3221@bigblue.dev.mdolabs.com>
 <1093330271.2792.3.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Arjan van de Ven wrote:

> On Mon, 2004-08-23 at 23:23, Davide Libenzi wrote:
> > The following patch implements a lazy I/O bitmap copy for the i386 
> > architecture. With I/O bitmaps now reaching considerable sizes, if the 
> > switched task does not perform any I/O operation, we can save the copy 
> > altogether. In my box X is working fine with the following patch, even if 
> > more test would be required.
> 
> the thing is that X will not hit your fault path, since it runs with
> iopl() called... your patch is a nice optimisation for X as a result,
> however as test, X is almost worthless ;(

Arjan, using FC1 here and X definitely hits the GPF path. A few crashes 
when doing The Wrong Thing confirmed it yesterday :-) Also, according to 
the snippet Alan posted, X does iopl() on fallback of failing ioperm() IIRC.



- Davide


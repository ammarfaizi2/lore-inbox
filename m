Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTDDV37 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTDDV37 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:29:59 -0500
Received: from fmr02.intel.com ([192.55.52.25]:47081 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261328AbTDDV35 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 16:29:57 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A24B@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, jjs@tmsusa.com, linux-kernel@vger.kernel.org
Subject: RE: [patch] acpi compile fix
Date: Fri, 4 Apr 2003 13:41:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@codemonkey.org.uk] 
> I don't see how putting a spinlock_t cast in the code is any 
> more portable between OS's than spinlock_t as a function parameter.

The code that calls osl.c does not know about spinlock_t. Either the
function's definition and declaration don't match, or the other code
needs to know what a spinlock_t is, doesn't it?

>  > If the above guesses (I'd prefer not to look) are correct then
>  > 	struct acpi_handle_t {
>  > 		spinlock_t lock;
>  > 	};
>  > 
>  > would make a ton more sense.
> 
> That would solve the portability argument in my eyes if that 
> is indeed the case here. It's still ugly, but it at least 
> kills the problem in a slightly more tasteful way.

I don't see the cast as being particularly onerous. It's just a cookie.
osl.c knows what it actually points to, the rest doesn't.

Regards -- Andy

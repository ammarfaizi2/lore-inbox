Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLDP6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 10:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLDP6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 10:58:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:7594 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262104AbTLDP6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 10:58:36 -0500
Date: Thu, 4 Dec 2003 07:58:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jason Kingsland <Jason_Kingsland@hotmail.com>
cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <BAY7-DAV34DV1amvu4600002bbe@hotmail.com>
Message-ID: <Pine.LNX.4.58.0312040753550.2055@home.osdl.org>
References: <Pine.LNX.4.58.0312031533530.2055@home.osdl.org>
 <BAY7-DAV34DV1amvu4600002bbe@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, Jason Kingsland wrote:
> >  - anything that has knowledge of and plays with fundamental internal
> >    Linux behaviour is clearly a derived work. If you need to muck around
> >    with core code, you're derived, no question about it.
>
>
> If that is the case, why the introduction of EXPORT_SYMBOL_GPL and
> MODULE_LICENSE()?

It is really just documentation.

This is exactly so that it is more clear which cases are black-and-white,
and where people shouldn't even have to think about it for a single
second. It still doesn't make the gray area go away, but it limits it a
bit ("if you need this export, you're clearly doing something that
requires the GPL").

Note: since the kernel itself is under the GPL, clearly anybody can modify
the EXPORT_SYMBOL_GPL() line, and remove the _GPL part. That wouldn't be
against the license per se. But it doesn't make a module that needs that
symbol any less needful of the GPL - exactly because the thing is just a
big cluehint rather than anything else.

			Linus

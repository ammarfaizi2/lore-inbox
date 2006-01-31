Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWAaNCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWAaNCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAaNCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:02:36 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34812 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750796AbWAaNCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:02:36 -0500
Subject: Re: i386 requires x86_64?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, "L. A. Walsh" <lkml@tlinx.org>
In-Reply-To: <20060130193129.19f04e6f.rdunlap@xenotime.net>
References: <43DED532.5060407@tlinx.org>
	 <20060130193129.19f04e6f.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 08:02:14 -0500
Message-Id: <1138712535.7088.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 19:31 -0800, Randy.Dunlap wrote:

> 
> Yes, there are bits in i386 that use x86_64 and there are
> bits in x86_64 that use i386 code, so that the source code
> won't have to be duplicated.

Perhaps we need an arch/x86_common that has this code.  Not just to help
those that like to delete other archs, but also to make it easier for us
that might modify the code and know that this code is shared.  It's
better design to have a arch/x86_common that is compiled with i386 and
x86_64 than to have code with - #include "../../x86_64/kernel/blah.c" -
in it.

-- Steve



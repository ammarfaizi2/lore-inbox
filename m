Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTISHNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTISHNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:13:11 -0400
Received: from khms.westfalen.de ([62.153.201.243]:64484 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP id S261396AbTISHNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:13:11 -0400
Date: 19 Sep 2003 08:55:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8uAuunHHw-B@khms.westfalen.de>
In-Reply-To: <20030917211200.GA5997@wotan.suse.de>
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
X-Mailer: CrossPoint v3.12d.kh12 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20030917202100.GC4723@wotan.suse.de> <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org> <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org> <20030917211200.GA5997@wotan.suse.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de (Andi Kleen)  wrote on 17.09.03 in <20030917211200.GA5997@wotan.suse.de>:

> On Wed, Sep 17, 2003 at 01:50:59PM -0700, Linus Torvalds wrote:

> > Also, you do things like comparing pointers for less/greater than, and at
> > least some versions of gcc has done that wrong - using signed comparisons.
>
> Really? Is that any version we still support (2.95+) ?
> It is certainly legal ISO-C. I changed it for now.

It certainly is *not* legal ISO C, and never was.

Pointer comparision is *only* legal in ISO C if both pointers point to the  
same object - same variable, or same piece of malloc'd memory. Anything  
else is undefined.

MfG Kai

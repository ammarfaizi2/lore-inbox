Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVAUViu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVAUViu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVAUVit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:38:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46238 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262515AbVAUVhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:37:22 -0500
Date: Fri, 21 Jan 2005 16:37:09 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Arnd Bergmann <arnd@arndb.de>
cc: Mark Williamson <maw48@cl.cam.ac.uk>, xen-devel@lists.sourceforge.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
In-Reply-To: <200501050111.59072.arnd@arndb.de>
Message-ID: <Pine.LNX.4.61.0501211634380.15744@chimarrao.boston.redhat.com>
References: <20050102162652.GA12268@lkcl.net> <1104785749.13302.26.camel@localhost.localdomain>
 <200501040304.10128.maw48@cl.cam.ac.uk> <200501050111.59072.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Arnd Bergmann wrote:

> - Pseudo faults:

These are a problem, because they turn what would be a single
pageout into a pageout, a pagein, and another pageout, in
effect tripling the amount of IO that needs to be done.

> - Ballooning:

Xen already has this.  I wonder if it makes sense to
consolidate the various balloon approaches into a single
driver, and keep the amount of ballooned memory into
account when reporting statistics in /proc/meminfo.

> When you want to introduce some interface in Xen, you probably want
> something more powerful than these,

Xen has a nice balloon driver, that can also be
controlled from outside the guest domain.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTGLKRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 06:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270010AbTGLKRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 06:17:12 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:42402 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270009AbTGLKRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 06:17:11 -0400
Date: Sat, 12 Jul 2003 11:34:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomas Szepe <szepe@pinerecords.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030712103420.GA22241@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Brian Gerst <bgerst@didntduck.org>,
	Steven Cole <elenstev@mesatop.com>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tomas Szepe <szepe@pinerecords.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <20030711144617.GK10217@louise.pinerecords.com> <1057935630.20637.19.camel@dhcp22.swansea.linux.org.uk> <20030711151127.GA30378@work.bitmover.com> <1057937849.2337.4.camel@spc9.esa.lanl.gov> <3F0EF939.90506@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0EF939.90506@didntduck.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 01:51:53PM -0400, Brian Gerst wrote:

 > There is no problem with the current version of this patch.  I rewrote 
 > the original patch to work around the bug in gcc.  The bug is that:
 > 
 > 	if (size < X) return kmem_cache_alloc(...);
 > 
 > would not cause the remaining if statements to be marked as dead code, but:
 > 
 > 	if (size < X) goto found;
 > 	...
 > 	found: return kmem_cache_alloc(...);
 > 
 > does optimize properly.

Ok, I'll drop that part from the next version of the doc.
It's not a critical thing that most users will notice.

		Dave


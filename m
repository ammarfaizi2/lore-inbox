Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUHXLYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUHXLYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHXLYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:24:20 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:42155 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267532AbUHXLXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:23:05 -0400
Date: Tue, 24 Aug 2004 12:22:45 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix MTRR strings definition.
Message-ID: <20040824112245.GA7847@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20040823232320.GA1875@redhat.com> <20040824081729.311ee677.ak@suse.de> <20040824110001.GD28237@redhat.com> <20040824131735.3980c21a.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824131735.3980c21a.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 01:17:35PM +0200, Andi Kleen wrote:

 > > The extern definitions no longer exist.
 > Your patch was: 

Oops. I missed the x86-64 one as I thought you killed that when you
killed the i386 one.

		Dave

 > --- latest-FC2/include/asm-x86_64/mtrr.h~	2004-08-24 00:20:17.377436336 +0100
 > +++ latest-FC2/include/asm-x86_64/mtrr.h	2004-08-24 00:21:04.137327752 +0100
 > @@ -69,6 +69,19 @@
 >  #define MTRR_TYPE_WRBACK     6
 >  #define MTRR_NUM_TYPES       7
 >  
 > +#ifdef MTRR_NEED_STRINGS
 > +static char *mtrr_strings[MTRR_NUM_TYPES] =
 > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 > +{
 > +	"uncachable",		/* 0 */
 > +	"write-combining",	/* 1 */
 > +	"?",			/* 2 */
 > +	"?",			/* 3 */
 > +	"write-through",	/* 4 */
 > +	"write-protect",	/* 5 */
 > +	"write-back",		/* 6 */
 > +};
 > +#endif
 > +
 >  #ifdef __KERNEL__
 >  
 >  extern char *mtrr_strings[MTRR_NUM_TYPES];
 > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 > 
 > -Andi
---end quoted text---

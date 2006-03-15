Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWCOAwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWCOAwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWCOAwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:52:06 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:42935 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751144AbWCOAwF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:52:05 -0500
Date: Tue, 14 Mar 2006 18:55:15 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Andi Kleen <ak@suse.de>,
       Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060315005514.GD7699@us.ibm.com>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu> <20060314230306.GB1579@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314230306.GB1579@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 12:03:06AM +0100, Pavel Machek wrote:
> Hi!
> 
> > +union tce_entry {
> > +   	u64 te_word;
> > +	struct {
> > +		unsigned int  read     :1;   /* read allowed */
> > +		unsigned int  write    :1;   /* write allowed */
> > +		unsigned int  hubid    :6;   /* hub id - unused */
> > +		unsigned int  rsvd     :4;   /* reserved */
> > +		unsigned long rpn      :36;  /* Real page number */
> > +		unsigned int  unused   :16;  /* unused */
> > +	} bits;
> > +};
> 
> I'd say this is going to be pretty flakey.

Why do you think this would be flakey?  It's nearly identical to the
tce_entry definition in include/asm-powerpc/tce.h (endien swapped, of
course).

Thanks,
Jon

> 
> 								Pavel
> 
> -- 
> 161:    {

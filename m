Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWCNX2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWCNX2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCNX2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:28:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43213 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932164AbWCNX2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:28:16 -0500
Date: Wed, 15 Mar 2006 00:03:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@suse.de>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060314230306.GB1579@elf.ucw.cz>
References: <20060314082432.GE23631@granada.merseine.nu> <20060314082552.GF23631@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314082552.GF23631@granada.merseine.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +union tce_entry {
> +   	u64 te_word;
> +	struct {
> +		unsigned int  read     :1;   /* read allowed */
> +		unsigned int  write    :1;   /* write allowed */
> +		unsigned int  hubid    :6;   /* hub id - unused */
> +		unsigned int  rsvd     :4;   /* reserved */
> +		unsigned long rpn      :36;  /* Real page number */
> +		unsigned int  unused   :16;  /* unused */
> +	} bits;
> +};

I'd say this is going to be pretty flakey.

								Pavel

-- 
161:    {

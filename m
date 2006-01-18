Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWARARg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWARARg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWARARg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:17:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:30175 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932512AbWARARd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:17:33 -0500
Subject: Re: [PATCH/RFC] Shared page tables
From: Dave Hansen <haveblue@us.ibm.com>
To: Robin Holt <holt@sgi.com>
Cc: Dave McCracken <dmccr@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20060117235302.GA22451@lnx-holt.americas.sgi.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>
	 <20060117235302.GA22451@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 16:17:30 -0800
Message-Id: <1137543450.27951.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-17 at 17:53 -0600, Robin Holt wrote:
> This appears to work on ia64 with the attached patch.  Could you
> send me any test application you think would be helpful for me
> to verify it is operating correctly?  I could not get the PTSHARE_PUD
> to compile.  I put _NO_ effort into it.  I found the following line
> was invalid and quit trying.
...
> +config PTSHARE
> +	bool "Share page tables"
> +	default y
> +	help
> +	  Turn on sharing of page tables between processes for large shared
> +	  memory regions.
...

These are probably best put in mm/Kconfig, especially if you're going to
have verbatim copies in each architecture.

-- Dave


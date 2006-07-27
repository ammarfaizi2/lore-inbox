Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWG0QS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWG0QS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWG0QS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:18:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60326 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751558AbWG0QSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:18:52 -0400
Date: Thu, 27 Jul 2006 09:18:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] CPU hotplug compatible alloc_percpu
Message-Id: <20060727091843.c2192bbc.pj@sgi.com>
In-Reply-To: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1153761414.2986.136.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> +static inline int percpu_populate_mask(void *__pdata, size_t size, gfp_t gfp,
> +				       int cpu)
> +{

It seems odd to me that this signature of percpu_populate_mask()
has its last argument 'int cpu' for the !CONFIG_SMP case, but
the SMP signatures have 'cpumask_t mask'.

Shouldn't this function signature be the same for all CONFIG's?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWBVWUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWBVWUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWBVWUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:20:09 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24987 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751507AbWBVWUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:20:07 -0500
Message-ID: <43FCE394.9010502@austin.ibm.com>
Date: Wed, 22 Feb 2006 16:20:04 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC][patch] mm: single pcp lists
References: <20060222143217.GI15546@wotan.suse.de>
In-Reply-To: <20060222143217.GI15546@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -struct per_cpu_pages {
> +struct per_cpu_pageset {
> +	struct list_head list;	/* the list of pages */
>  	int count;		/* number of pages in the list */
> +	int cold_count;		/* number of cold pages in the list */
>  	int high;		/* high watermark, emptying needed */
>  	int batch;		/* chunk size for buddy add/remove */
> -	struct list_head list;	/* the list of pages */
> -};

Any particular reason to move the list_head to the front?

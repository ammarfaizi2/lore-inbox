Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVKWGm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVKWGm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVKWGm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:42:26 -0500
Received: from graphe.net ([209.204.138.32]:52910 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S1030320AbVKWGmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:42:25 -0500
Date: Tue, 22 Nov 2005 22:42:23 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Rohit Seth <rohit.seth@intel.com>, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Free pages from local pcp lists under tight memory
 conditions
In-Reply-To: <20051122213612.4adef5d0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0511222238530.2084@graphe.net>
References: <20051122161000.A22430@unix-os.sc.intel.com>
 <20051122213612.4adef5d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Andrew Morton wrote:

> +extern int drain_local_pages(void);

drain_cpu_pcps?

The naming scheme is a bit confusing right now. We drain the pcp 
structures not pages so maybe switch to pcp and then name each function so 
that the function can be distinguishes clearlyu?

> +static int drain_all_local_pages(void)

drain_all_pcps?


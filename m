Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVCRXJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVCRXJL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 18:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVCRXJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 18:09:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:2783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbVCRXJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 18:09:03 -0500
Date: Fri, 18 Mar 2005 15:08:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       apw@shadowen.org
Subject: Re: [RFC][PATCH 5/6] sparsemem: more separation between NUMA and
 DISCONTIG
Message-Id: <20050318150826.4ca3ad14.akpm@osdl.org>
In-Reply-To: <E1DBisA-0000l4-00@kernel.beaverton.ibm.com>
References: <E1DBisA-0000l4-00@kernel.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
>  There is some confusion with the SPARSEMEM patch between what
>  is needed for DISCONTIG vs. NUMA.  For instance, the NODE_DATA()
>  macro needs to be switched on NUMA, but not on FLATMEM.
> 
>  This patch is required if the previous patch is applied.

This patch breaks !CONFIG_NUMA ppc64:

include/linux/mmzone.h:387:1: warning: "NODE_DATA" redefined
include/asm/mmzone.h:55:1: warning: this is the location of the previous definition

I'll hack around it for now.

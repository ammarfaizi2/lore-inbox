Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUKXQ53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUKXQ53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKXQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:54:57 -0500
Received: from over.ny.us.ibm.com ([32.97.182.111]:40390 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S262692AbUKXQxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:53:50 -0500
Subject: Re: Suspend 2 merge: 18/51: Debug page_alloc support.
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@linuxmail.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101295326.5805.259.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295326.5805.259.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101312173.8940.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 24 Nov 2004 08:02:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 04:58, Nigel Cunningham wrote:
> +#ifdef CONFIG_HIGHMEM
> +	if (page >= highmem_start_page) 
> +		return 0;
> +#endif

There's a patch pending in -mm to kill highmem_start_page.  Please use
PageHighMem().

-- Dave


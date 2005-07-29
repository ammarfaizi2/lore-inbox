Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVG2UMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVG2UMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbVG2UJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:09:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262783AbVG2UHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:07:22 -0400
Date: Fri, 29 Jul 2005 13:05:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] Fix NUMA node sizing in nr_free_zone_pages
Message-Id: <20050729130558.22039a95.akpm@osdl.org>
In-Reply-To: <240970000.1122661910@[10.10.2.4]>
References: <240970000.1122661910@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
>  We are iterating over all nodes in nr_free_zone_pages(). Because the 
>  fallback zonelists contain all nodes in the system, and we walk all
>  the zonelists, we're counting memory multiple times (once for each
>  node). This caused us to make a size estimate of 32GB for an 8GB
>  AMD64 box, which makes all the dirty ratio calculations, etc incorrect.

Thanks, Martin.

Just for reference: this patch addresses the "Memory pressure handling with
iSCSI" problems which Badari Pulavarty reported.


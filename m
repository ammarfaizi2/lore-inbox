Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVHQXct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVHQXct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHQXct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:32:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbVHQXcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:32:48 -0400
Date: Wed, 17 Aug 2005 16:35:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH 1/32] include: update jiffies/{m,u}secs conversion
 functions
Message-Id: <20050817163506.58e37fb0.akpm@osdl.org>
In-Reply-To: <20050815180617.GD2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
	<20050815180617.GD2854@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> wrote:
>
> Description: Clarify the human-time units to jiffies conversion
> functions by using the constants in time.h. This makes many of the
> subsequent patches direct copies of the current code.
> 
>  
>  /* Parameters used to convert the timespec values */
> +#ifndef MSEC_PER_SEC
> +#define MSEC_PER_SEC (1000L)
> +#endif
> +
>  #ifndef USEC_PER_SEC
>  #define USEC_PER_SEC (1000000L)
>  #endif

Bah.  There's no MSEC_PER_SEC defined anywhere in the tree, so the ifndef
isn't needed.  Nor is the one for USEC_PER_SEC, come to that.  I'll kill
them.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWIAO6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWIAO6I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 10:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIAO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 10:58:07 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17822 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750739AbWIAO6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 10:58:05 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060901110948.GD15684@skybase>
References: <20060901110948.GD15684@skybase>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 07:57:47 -0700
Message-Id: <1157122667.28577.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:09 +0200, Martin Schwidefsky wrote:
> +#define PG_state_change                21      /* HV page state is changing. */
> +#define PG_discarded           22      /* HV page has been discarded. */ 

We're already desperately short on page flags on 32-bit architectures.
It seems a wee bit silly to add two arch-generic flags for what is a
very specialized arch-specific feature at this point.

I know that there are 32-bit s390 kernels, but would this be a
reasonable feature to restrict to only 64-bit kernels?  That might be a
decent compromise.

-- Dave


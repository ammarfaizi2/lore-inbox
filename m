Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWEOOVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWEOOVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWEOOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:21:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21894 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964939AbWEOOVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:21:38 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Dave Hansen <haveblue@us.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Cc: Christoph Lameter <christoph@engr.sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1147363859.24029.134.camel@localhost.localdomain>
References: <1147287400.24029.81.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605101633140.7639@schroedinger.engr.sgi.com>
	 <1147363859.24029.134.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 15 May 2006 07:20:17 -0700
Message-Id: <1147702817.6623.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-11 at 11:10 -0500, Adam Litke wrote:
> Yes, the SIGBUS issues are "fixed".  Now the application is killed
> directly via VM_FAULT_OOM so it is not possible to handle the fault from
> userspace.  For my libhugetlbfs-based fallback approach, I needed to
> patch the kernel so that SIGBUS was delivered to the process like in the
> days of old.

Maybe this could be off-by-default behavior that can be enabled with a
special mmap flag or madvise, or something similar.  It seems that apps
don't want to get SIGBUS for low memory.  But, if they have _asked_ for
it, perhaps they'd be a bit more willing.

(BTW, I fixed the bogus linux-mm cc, finally ;)

-- Dave


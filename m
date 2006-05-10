Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWEJViv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWEJViv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWEJViv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:38:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:15086 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965017AbWEJViu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:38:50 -0400
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Hugetlb demotion for x86
References: <1147287400.24029.81.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 10 May 2006 23:38:48 +0200
In-Reply-To: <1147287400.24029.81.camel@localhost.localdomain>
Message-ID: <p73vesd7e6v.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke <agl@us.ibm.com> writes:

> The following patch enables demotion of MAP_PRIVATE hugetlb memory to
> normal anonymous memory on the i386 architecture.  Below is a short
> description of the problem from a previous posting.


I'm not sure it's a good idea really. I think people have the reasonable
expection that if you use hugetlb you really get huge pages.

If you really implement you should at least printk clearly. But it's 
probably better to not implement it.

If there was generic transparent hugepages support in the VM the case
would be probably different. Then it would make sense. But not as part
of hugetlbfs.

-Andi

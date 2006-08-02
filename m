Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWHBDT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWHBDT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 23:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWHBDT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 23:19:27 -0400
Received: from mail.suse.de ([195.135.220.2]:11242 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751097AbWHBDT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 23:19:26 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 12 of 13] Pass the mm struct into the pgd_free code so the mm is available here
Date: Wed, 2 Aug 2006 05:14:52 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Andrew Morton <akpm@osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Christoph Lameter <clameter@sgi.com>
References: <8235caea9d688b78ce4b.1154462450@ezr>
In-Reply-To: <8235caea9d688b78ce4b.1154462450@ezr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020514.52316.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nst char *arch_vma_name(struct vm_area_struct *vma);
>  
> +#ifndef pgd_free_mm
> +#define pgd_free_mm(mm) pgd_free((mm)->pgd)
> +#endif

Sorry, but these ifdefs are too ugly. I would prefer if you 
just updated all architectures, even though it will make the patch
somewhat bigger

-Andi

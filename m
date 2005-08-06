Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVHFLiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVHFLiC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 07:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVHFLiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 07:38:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:45748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262073AbVHFLhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 07:37:32 -0400
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer  (i386)
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Aug 2005 13:37:31 +0200
In-Reply-To: <42F46558.9010202@vmware.com.suse.lists.linux.kernel>
Message-ID: <p73wtmz1ekk.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> i386 Transparent paravirtualization sub-arch patch #8.
> 
> Transparent paravirtualization support for MMU operations.
> 
> All operations which update live page table entries have been moved to the
> sub-architecture layer.  Unfortunately, this required yet another parallel set
> of pgtable-Nlevel-ops.h files, but this avoids the ugliness of having to use
> #ifdef's all of the code.
> 
> This is pure code motion.  Anything else would be a bug.

I think that patch is really ugly - it makes hacking VM on i386
even more painful than it already is because the convolutes the file
structure even more. Hope it is not applied.

-Andi

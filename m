Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUHFPv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUHFPv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268164AbUHFPup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:50:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53964 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268157AbUHFPtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:49:08 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200408061547.i76FlY8U009151@ben.americas.sgi.com>
Subject: Re: Altix I/O code reorganization
To: hch@infradead.org (Christoph Hellwig)
Date: Fri, 6 Aug 2004 10:47:34 -0500 (CDT)
Cc: pfg@sgi.com (Pat Gefre), linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040806141836.A9854@infradead.org> from "Christoph Hellwig" at Aug 06, 2004 02:18:36 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> 006-bte:
>   Please merge bte_error.c into the existing bte.c

bte_crb_error_handler() is called from hubiio_crb_error_handler()
in arch/ia64/sn/io/sn2/shuberror.c.  That's why bte_error.c is
in the same directory as shuberror.c (and not in arch/ia64/sn/kernel
with bte.c).

If bte_error.c is merged, wouldn't it make more sense to
merge it with shuberror.c?

Thanks,
-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com

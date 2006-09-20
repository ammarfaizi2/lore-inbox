Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWITVid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWITVid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWITVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:38:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:55275 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932144AbWITVib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:38:31 -0400
Subject: Re: 2.6.19 -mm merge plans
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 14:42:01 -0700
Message-Id: <1158788521.1198.19.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:54 -0700, Andrew Morton wrote:

Sorry, I didn't get back to this earlier. I have been chasing
one more ext2 & ext3 regression (this time with random reads).
Anyway ..

> add-address_space_operationsbatch_write.patch
> add-address_space_operationsbatch_write-fix.patch
> pass-io-size-to-batch_write-address-space-operation.patch
> 
>  These add a new address_space operation.  For reiser4, with potential for
>  use by other filesystems.
> 
>  Problem is, 2.6.18 has a significant writev() performace regression on NFS
>  and probably on other filesystems.  Because 2.6.18 does
>  prepare_write/commit_write for each iovec segment.  We want to go back to
>  copying mulitple iovec segments within a single prepare_write/commit_write.
> 
>  Plus there's still the possible deadlock in our standard write() function
>  (thw thing which fault_in_pages_readable() tries to prevent).
> 
>  All of this should be fixed.  


What needs to be fixed here ?

Thanks,
Badari


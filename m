Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290490AbSBKVhg>; Mon, 11 Feb 2002 16:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290496AbSBKVh1>; Mon, 11 Feb 2002 16:37:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:16046 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290490AbSBKVhQ>; Mon, 11 Feb 2002 16:37:16 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202112137.g1BLb3I19212@eng2.beaverton.ibm.com>
Subject: Re: patch: aio + bio for raw io
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Mon, 11 Feb 2002 13:37:03 -0800 (PST)
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020208025313.A11893@redhat.com> from "Benjamin LaHaise" at Feb 08, 2002 01:53:13 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Quick message: this patch makes aio use bio directly for brw_kvec_async.  
> This is against yesterday's patchset.  Comments?
> 
Hi Ben,

I have one more question on your latest aio patch.

raw_kvec_rw() seem to handle max upto 512K (max_sectors = 2500). 
But I don't see any where you loop thro to satisfy the entire 
IO request.

Infact, generic_aio_read() is mapping the user buffer for the iosize 
and calling file->f_op->kvec_read(file, cb, iosize, pos). 
How does the io > 512K gets handled ?

NOTE: I have not looked at the userlevel code. Is IO split at max 512K
      at userlevel ?

Thanks,
Badari

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbSKMHw0>; Wed, 13 Nov 2002 02:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267136AbSKMHw0>; Wed, 13 Nov 2002 02:52:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:49293 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267135AbSKMHwZ>;
	Wed, 13 Nov 2002 02:52:25 -0500
Date: Wed, 13 Nov 2002 13:43:42 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org, richard <richardj_moore@uk.ibm.com>,
       tom <hanrahat@us.ibm.com>
Subject: Re: How can I verify a memory address exist?
Message-ID: <20021113134342.B3171@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <000b01c28aa8$ac0235c0$77d40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000b01c28aa8$ac0235c0$77d40a0a@amr.corp.intel.com>; from rusty@linux.co.intel.com on Wed, Nov 13, 2002 at 12:48:44AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 12:48:44AM +0000, Rusty Lynch wrote:
> Is there a kernel function to find out if a given memory address exist?
> 
I think you are trying to validate addresses to be passed into kprobes.
In that context, you need to check if the given address is a kernel
space code address. 

Take a look at kernel_text_address() functions in 
arch/i386/kernel/traps.c which do this. Unfortunately, they are defined
static inline, so, they can't be used outside of traps.c. You may
want to export that function from kernel and use it in your driver.

Cheers,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVKRDiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVKRDiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVKRDiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:38:01 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:20900 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932263AbVKRDh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:37:59 -0500
Date: Fri, 18 Nov 2005 09:07:55 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, ak@suse.de,
       ebiederm@xmission.com
Subject: Re: [PATCH 2/10] kdump: dynamic per cpu allocation of memory for saving cpu registers
Message-ID: <20051118033755.GA3779@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117140138.454c59a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117140138.454c59a8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 02:01:38PM -0800, Andrew Morton wrote:
> 
> Please always generate diffs against the latest kernel!  I changed the
> patch to reflect the new location of ppc64's machine_kexec.c.
> 

Sorry. That's a mistake. I shall take care of it next time onwards.

> In that file, I notice that this comment has become more informative:
> 
> /*
>  * Provide a dummy crash_notes definition until crash dump is implemented.
>  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
>  */
> note_buf_t crash_notes[NR_CPUS];
> 
> Please check that with your new implementation, the above "breakage"
> (whatever it was) remains fixed.
>

With this patchset "crash_notes" has been moved in architecture independent
portion (). Hence there is no need for architecture dependent definitions.
So this change should be fine.

Thanks
Vivek 

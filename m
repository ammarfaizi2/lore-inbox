Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUHSQWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUHSQWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUHSQWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:22:35 -0400
Received: from holomorphy.com ([207.189.100.168]:28353 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266622AbUHSQWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:22:33 -0400
Date: Thu, 19 Aug 2004 09:22:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernbench on 512p
Message-ID: <20040819162231.GS11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <200408191216.33667.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408191216.33667.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 12:16:33PM -0400, Jesse Barnes wrote:
> Here's the kernel profile.  It would be nice if the patch to show which lock 
> is contended got included.  I think it was discussed awhile back, but I don't 
> have one against the newly merged profiling code.
> [root@ascender root]# readprofile -m System.map | sort -nr | head -30
> 208218076 total                                     30.1677
> 90036167 ia64_pal_call_static                     468938.3698
> 88140492 default_idle                             229532.5312
> 10312592 ia64_save_scratch_fpregs                 161134.2500
> 10306777 ia64_load_scratch_fpregs                 161043.3906
> 8723555 ia64_spinlock_contention                 90870.3646
> 121385 rcu_check_quiescent_state                316.1068
>  40464 file_move                                180.6429
>  32374 file_kill                                144.5268
>  25316 atomic_dec_and_lock                       98.8906
>  24814 clear_page                               155.0875
>  17709 file_ra_state_init                       110.6813
>  17603 clear_page_tables                         13.4169

file_move()? file_kill()? I smell files_lock.


-- wli

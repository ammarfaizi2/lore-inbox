Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbVD3A6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVD3A6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVD3A6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:58:32 -0400
Received: from fmr24.intel.com ([143.183.121.16]:23220 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S263105AbVD3A4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:56:47 -0400
Date: Fri, 29 Apr 2005 17:56:30 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 dual core mapping
Message-ID: <20050429175629.A23904@unix-os.sc.intel.com>
References: <3174569B9743D511922F00A0C943142309B079F4@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3174569B9743D511922F00A0C943142309B079F4@TYANWEB>; from YhLu@tyan.com on Thu, Apr 28, 2005 at 12:49:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 12:49:42PM -0700, YhLu wrote:
> Please refer to my patch about that.
> 
> --- smpboot.o.c 2005-04-28 13:00:03.611550488 -0700
> +++ smpboot.c   2005-04-28 12:59:27.151093320 -0700
> @@ -652,7 +652,7 @@
>                 int i;
>                 if (smp_num_siblings > 1) {
>                         for_each_online_cpu (i) {
> -                               if (cpu_core_id[cpu] == cpu_core_id[i]) {
> +                               if (cpu_to_node[cpu] == cpu_to_node[i]) {
>                                         siblings++;
>                                         cpu_set(i, cpu_sibling_map[cpu]);
>                                 }

This patch is wrong. It will break Intel systems and I think it is also not 
the correct fix for the systems you are trying to fix.

Please don't do this.

thanks,
suresh

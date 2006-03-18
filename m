Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWCRW00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCRW00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWCRW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:26:26 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:61119 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751068AbWCRW0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:26:25 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Date: Sat, 18 Mar 2006 17:26:26 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alex-kernel@digriz.org.uk, jun.nakajima@intel.com,
       Dave Jones <davej@redhat.com>
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603181726.26311.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 16:40, Linus Torvalds wrote:
> Anyway, I _think_ it's this one:
>
>                 for_each_online_cpu(j) {
>                         dbs_info = &per_cpu(cpu_dbs_info, j);
>                         requested_freq[j] = dbs_info->cur_policy->cur;
>                 }
>
> where dbs_info->cur_policy seems to be NULL. Maybe.

That was right on target.
I just put  a check in the code which confirms that for some reason cur_policy 
for cpu0 is NULL.

Parag 

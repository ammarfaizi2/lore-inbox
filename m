Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWEEGt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWEEGt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 02:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWEEGt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 02:49:56 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48342
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751505AbWEEGt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 02:49:56 -0400
Message-Id: <445B11F1.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 05 May 2006 08:50:57 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Suresh B Siddha" <suresh.b.siddha@intel.com>
Cc: <akpm@osdl.org>, <tigran@veritas.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix x86 microcode driver handling of multiple
	matching revisions
References: <444F9D34.76E4.0078.0@novell.com><444F9D34.76E4.0078.0@novell.com>; from jbeulich@novell.com on Wed, Apr 26, 2006 at 04:17:56PM +0200 <20060504100940.A2571@unix-os.sc.intel.com>
In-Reply-To: <20060504100940.A2571@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +		for_each_online_cpu(cpu_num) {
>> +			if (ucode_cpu_info[cpu_num].mc == uci->mc) {
>> +				uci->mc = NULL;
>> +				break;
>> +			}
>
>Isn't there a memory leak here? Shouldn't this be
>		for_each_online_cpu(cpu) {
>			if (cpu == cpu_num)
>				continue;
>			if (ucode_cpu_info[cpu].mc == uci->mc) {
>				uci->mc = NULL;
>				break;
>			}
>		}

Indeed, I'll send an updated patch later.

Jan

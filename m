Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVI2OOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVI2OOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVI2OOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:14:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:36513 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932159AbVI2OOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:14:43 -0400
Date: Thu, 29 Sep 2005 19:43:41 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, systemtap@sources.redhat.com,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Subject: Re: [discuss] [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Message-ID: <20050929141341.GA10273@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Sep 29, 2005 at 08:43:44AM +0800, Zhang, Yanmin wrote:
>>  <<kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch>> I found it
>> when reading the source codes. Basically, the bug could break
>> kprobe_insn_pages under multi-thread environment. PPC arch also has the
>> problem.

>Can you describe what the problem actually is? 

Andi,

The up()/down() orders are incorrect in arch/x86_64/kprobes.c file while
trying to get/remove a kprobes instruction slot in arch_prepare_kprobe() 
and arch_remove_kprobe() routines. Zhang's patch corrects this.


Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

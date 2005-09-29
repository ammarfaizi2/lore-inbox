Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVI2ObI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVI2ObI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 10:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVI2ObI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 10:31:08 -0400
Received: from ns.suse.de ([195.135.220.2]:14521 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932166AbVI2ObH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 10:31:07 -0400
From: Andi Kleen <ak@suse.de>
To: prasanna@in.ibm.com
Subject: Re: [discuss] [PATCH] utilization of kprobe_mutex is incorrect on x86_64
Date: Thu, 29 Sep 2005 16:31:09 +0200
User-Agent: KMail/1.8.2
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, systemtap@sources.redhat.com,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
References: <20050929141341.GA10273@in.ibm.com>
In-Reply-To: <20050929141341.GA10273@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509291631.10087.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 16:13, Prasanna S Panchamukhi wrote:
> >On Thu, Sep 29, 2005 at 08:43:44AM +0800, Zhang, Yanmin wrote:
> >>  <<kprobe_incorrect_kprobe_mutex_2.6.14-rc2_x86_64.patch>> I found it
> >> when reading the source codes. Basically, the bug could break
> >> kprobe_insn_pages under multi-thread environment. PPC arch also has the
> >> problem.
> >
> >Can you describe what the problem actually is?
>
> Andi,
>
> The up()/down() orders are incorrect in arch/x86_64/kprobes.c file while
> trying to get/remove a kprobes instruction slot in arch_prepare_kprobe()
> and arch_remove_kprobe() routines. Zhang's patch corrects this.

What I meant is that someone should describe why they are incorrect.
I could probably figure it out from the code, but in general the standards
for changelogs are higher than just "bla is wrong". It should be more like
"bla doesn't do X, so bad thing Y happens, which causes crash Z". Please 
follow this in future patches.

-Andi

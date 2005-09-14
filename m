Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbVINVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbVINVGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbVINVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:06:31 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38076 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932759AbVINVGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:06:30 -0400
Message-ID: <432890BA.5090907@engr.sgi.com>
Date: Wed, 14 Sep 2005 14:06:02 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lserinol@gmail.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       kaigai@ak.jp.nec.com, elsa-devel@lists.sourceforge.net,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       John Hesterberg <jh@sgi.com>
Subject: Re: [PATCH] per process I/O statistics for userspace
References: <2c1942a7050912052759c7f730@mail.gmail.com>	<20050914092338.GA2260@elf.ucw.cz>	<2c1942a705091413171e63bf55@mail.gmail.com> <20050914132437.7c32b739.akpm@osdl.org>
In-Reply-To: <20050914132437.7c32b739.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

These data are used in CSA Accounting today and i believe ELSA
intends to use them also.

Since PAGG is not in the tree, SGI have been offering our customers
PAGG/JOB/CSA kernel code as either kernel patches at oss.sgi.com
site or out-of-tree kernel modules today.

SGI intends to submit another solution for PAGG/JOB soon.

Once the future of PAGG/JOB becomes clear, we will know better how
to integrate CSA and BSD accounting. We are not sitting on it.

Thanks,
  - jay


Andrew Morton wrote:
> Levent Serinol <lserinol@gmail.com> wrote:
> 
>>+int proc_pid_iostat(struct task_struct *task, char *buffer)
>> +{
>> +       return sprintf(buffer,"%llu %llu\n",task->rchar,task->wchar);
>> +}
> 
> 
> Those fields have been sitting there unused for months.  I'd like to hear
> what the system accounting guys are intending to do with them before
> proceeding, please.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


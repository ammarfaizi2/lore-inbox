Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTBQSjN>; Mon, 17 Feb 2003 13:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTBQSjN>; Mon, 17 Feb 2003 13:39:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30108 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267236AbTBQSjM>; Mon, 17 Feb 2003 13:39:12 -0500
Date: Mon, 17 Feb 2003 10:49:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
cc: linux-kernel@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.5] IRQ distribution patch for 2.5.58
Message-ID: <11660000.1045507742@[10.10.2.4]>
In-Reply-To: <20030217181614.GP29983@holomorphy.com>
References: <E88224AA79D2744187E7854CA8D9131DA5CE8D@fmsmsx407.fm.intel.com> <20030217181614.GP29983@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Dave already sent out a fix for that at the weekend.

M.

--On Monday, February 17, 2003 10:16:14 -0800 William Lee Irwin III <wli@holomorphy.com> wrote:

> On Thu, Jan 16, 2003 at 01:08:55PM -0800, Kamble, Nitin A wrote:
>> +		spin_lock(&desc->lock);
>> +		irq_balance_mask[selected_irq] = target_cpu_mask;
>> +		spin_unlock(&desc->lock);
> 
> Wrong.
> 
> 		irq_balance_mask[selected_irq] = cpu_to_logical_apicid(min_loaded);
> 
> ... except this needs auditing for the assumption that the RTE's are
> using logical DESTMOD.
> 
> Guess whose box won't boot with your code in?
> 
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



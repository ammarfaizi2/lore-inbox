Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSI1Edf>; Sat, 28 Sep 2002 00:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262713AbSI1EdU>; Sat, 28 Sep 2002 00:33:20 -0400
Received: from holomorphy.com ([66.224.33.161]:50860 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262712AbSI1Ec6>;
	Sat, 28 Sep 2002 00:32:58 -0400
Date: Fri, 27 Sep 2002 21:36:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020928043655.GU3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20020927152833.D25021@in.ibm.com> <Pine.LNX.4.44.0209280034101.32347-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209280034101.32347-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 27 Sep 2002, Dipankar Sarma wrote:
>> The counts are off by one.
>> With a UP kernel, I see that fget() cost is negligible.
>> So it is most likely the atomic operations for rwlock acquisition/release
>> in fget() that is adding to its cost. Unless of course my sampling
>> is too less.

On Sat, Sep 28, 2002 at 12:35:30AM -0400, Zwane Mwaikambo wrote:
> Mine is a UP box not an SMP kernel, although preempt is enabled;
> 0xc013d370 <fget>:      push   %ebx
> 0xc013d371 <fget+1>:    mov    %eax,%ecx
> 0xc013d373 <fget+3>:    mov    $0xffffe000,%edx
> 0xc013d378 <fget+8>:    and    %esp,%edx
> 0xc013d37a <fget+10>:   incl   0x4(%edx)

Do you have instruction-level profiles to show where the cost is on UP?


Thanks,
Bill

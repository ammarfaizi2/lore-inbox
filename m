Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSFYGrG>; Tue, 25 Jun 2002 02:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSFYGrF>; Tue, 25 Jun 2002 02:47:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39580 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315449AbSFYGrF>;
	Tue, 25 Jun 2002 02:47:05 -0400
Message-ID: <3D1811CD.70103@us.ibm.com>
Date: Mon, 24 Jun 2002 23:46:37 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: acenic >4gig sendfile problem
References: <3D05204B.4010103@us.ibm.com> <m3r8iwvgl8.fsf@trained-monkey.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
>>>>>>"Dave" == Dave Hansen <haveblue@us.ibm.com> writes:
>>>>>
> 
> Dave> When doing sendfile with my acenic card on my 8xPIII-700 and PAE
> Dave> running 2.4.18, I'm getting all zeros in the files being
> Dave> transmitted.  Running the Redhat 2.4.18-4 kernel fixes the
> Dave> problem.  I saw this entry in the rpm's changelog: * Sat Aug 25
> Dave> 2001 Ingo Molnar <mingo@redhat.com> - fix the acenic driver bug
> Dave> that caused random kernel memory being sent out on the wire, on
> Dave> x86 systems with more than 4 GB RAM.
> 
> Actually I think you're hitting a bug in pci_map_page() rather than in
> the acenic.driver.
> 
> Try the patch from Ben LaHaise included below.
> 

Thanks for the patch.  I'll give it a shot when I get back from OLS.

-- 
Dave Hansen
haveblue@us.ibm.com


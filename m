Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTB0WPP>; Thu, 27 Feb 2003 17:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTB0WPP>; Thu, 27 Feb 2003 17:15:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54215 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267204AbTB0WPM>; Thu, 27 Feb 2003 17:15:12 -0500
Date: Thu, 27 Feb 2003 14:16:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
cc: akpm@digeo.com
Subject: Re: [BENCHMARK] AIM9 results. 2.4.19 vs 2.5.58 vs 2.5.63
Message-ID: <189330000.1046384176@flay>
In-Reply-To: <20030227213954.2125.qmail@linuxmail.org>
References: <20030227213954.2125.qmail@linuxmail.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> page_test 10000 123.9       210630.00 System Allocations & Pages/second
> page_test 10000 102.8       174760.00 System Allocations & Pages/second
> page_test 10010 101.898       173226.77 System Allocations & Pages/second
> ^^^^^Here we are still slowe then 2.4.19
>
> brk_test 10010 48.951       832167.83 System Memory Allocations/second
> brk_test 10000 43.7       742900.00 System Memory Allocations/second
> brk_test 10020 41.018       697305.39 System Memory Allocations/second
> ^^^^Slower then .58 and a lot slower then 2.4.19
>
> exec_test 10000 13.8           69.00 Program Loads/second
> exec_test 10030 12.8614           64.31 Program Loads/second
> exec_test 10020 12.7745           63.87 Program Loads/second
> ^^^^ Slower then 2.4.19
> 
> fork_test 10000 44.8         4480.00 Task Creations/second
> fork_test 10020 24.8503         2485.03 Task Creations/second
> fork_test 10000 23.2         2320.00 Task Creations/second
> ^^^^^ A lot slower then 2.4.19

Could you compare 63 mainline to -mjb or -mm with objrmap patches in?
I think you'll get significant improvements on the tests above.

> mem_rtns_1 10000 27.7       831000.00 Dynamic Memory Operations/second
> mem_rtns_1 10000 24.1       723000.00 Dynamic Memory Operations/second
> mem_rtns_1 10020 22.7545       682634.73 Dynamic Memory Operations/second
> ^^^^^Slow, slow, slow...
> 
> misc_rtns_1 10000 782.2         7822.00 Auxiliary Loops/second
> misc_rtns_1 10000 706         7060.00 Auxiliary Loops/second
> misc_rtns_1 10000 686.9         6869.00 Auxiliary Loops/second
> ^^^^ Slow too...
> 
> shared_memory 10000 2227.4       222740.00 Shared Memory Operations/second
> shared_memory 10000 1973.1       197310.00 Shared Memory Operations/second
> shared_memory 10000 1955.2       195520.00 Shared Memory Operations/second
> ^^^^Slow, slow, slow...

And possibly those three as well, though I'm less sure.
 
Thanks,

M.


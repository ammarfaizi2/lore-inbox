Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946165AbWJSQHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946165AbWJSQHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946169AbWJSQHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:07:24 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:32454 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1946165AbWJSQHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:07:22 -0400
Message-ID: <4537A2A1.70304@cn.ibm.com>
Date: Fri, 20 Oct 2006 00:06:57 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: mreedltp@vnet.ibm.com
CC: ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [LTP] [ANNOUNCE]  The Linux Test project ltp-20061017 Released
References: <45354FE0.8020308@vnet.ibm.com>
In-Reply-To: <45354FE0.8020308@vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reed 写道:
> The Linux Test Project test suite <http://www.linuxtestproject.org> has  
Are you sure this link can work?
I can only access it by http://ltp.sourceforge.net/
> been released. The latest version of the testsuite contains 2900+ tests  
> for the Linux OS. Our web site also contains other information such as:
> - A Linux test tools matrix
> - Technical papers
> - How To's on Linux testing
> - Code coverage analysis tool.
>  
> Release Highlights:
> Code Cleanups by Yi Xu, Jeff Burke, Darrick Wong,  Mike Frysinger, 
> Michael Reed
>  
> We encourage the community to post results to ltp-results@lists.sf.net,  
> and patches, new tests, or comments/questions to ltp-list@lists.sf.net
>  
> See ChangeLog Below
> -A fix for Bug 23587 where the connectathon test failed on linux client 
> with cifs mount to Windows2003 R2 server
> op_chmod.c
> 
> 
> -For Linux, 3 is a valide value for the scheduler, as found in the 
> /linux/includ/sched.h file.   For testing and invalid_policy, the 
> invalid_policy value should not be 3
> 17-5.c
> 
> 
> Sem_post/5.-1.c According to its intention, #3, call sleep(1) and then 
> alarm(1).  Moving sleep before alarm causes the test to pass  
> sem_post/8-1.c Although step 3 intended,  The children lock the 
> semaphore. * Make sure the two children are waiting."  Without that 
> caeratn piece of cde which explicity make children wat.  the test will 
> PASS and the children are waiting.  Sem_unlink_1_1 and sem_unline_2_1 
> "Sem_unlink" is too long for the name of a semaphore for certain 
> architectures
> 5-1.c, 8-1.c, 1-1.c, 2-1.c
> 
> 
> -When calling pthread_attr_setscope, PHREAD_SCOPE_PROCESS is not 
> supported by linux, change it to PTHREAD_SCOPE_SYSTEM and the test will 
> pass
> 20-1.c, 21-1.c, 21-2.c
> 
> 
> -Removed the  ":" after 'v' in the getopts line because it is not using 
> optarg.
> runltplite.sh
> 
> 
> -Added code to disable tests that will not run on kernels below 2.6.16
> faccessat01.c, fchmodat01.c, fchownat01.c, fstatat01.c, futimesat01.c, 
> linkat01.c, mknod01.c, openat01.c, readlinkat01.c, renameat01.c, 
> symlinkat01.c, tee01.c, unlinkat01.c, vmsplice01.c
> 
> 
> -When calling pthread_attr_setscope, PHREAD_SCOPE_PROCESS is not 
> supported by linux, change it to PHTREAD-SCOPE_SYSTEM for testing and 
> then the test passes.
> 22-1.c, 22-2.c
> 
> 
> -A patch by David Stevens that fixes: 1) Removes signedness warning by 
> changing the type of valsize from int to socklen_t 2) Correct but in 
> ancillary data - sorce data is unit8_t, memcopy size is "sizeof(int)"; 
> this results in garbage and TBROK on PPC64
> asapi_06.c
> 
> 
> -A fix for bugs 27174 and 27177.  This fixes the problem of reading 
> HugePages_Free
> hugemmap01.c, hugemmap04.c
> 
> 
> -Correcting error messages
> ltpapicmd.c
> 
> -This patch by Darrick Wong fixes complier warnings and overflow 
> problems related to the use of large number #defines on some architectures.
> inconsistency-check.c
> 
> 
> -When calling pthread_attr_setscope, PTHREAD_SCOPE_PROCESS is not 
> supported by linux, change it to PTHREAD_SCOPE_SYSTEM for testing
> 15-1.c, 15-2.c
> 
> 
> -A fix for bug #27618 that addresses two issues: 1) PAGE_SIZE which was 
> normally 4096, but on the machine it found to 64k ! 2) The size of the 
> file, offset passed. If those values, happen to be on the *Page 
> boundary*, mmap would be happy. But in our case, it was not !
> fsx-linux.c
> 
> 
> -Changing include <posixtest.h> to include "posixtest.h"
> 1-1.c
> 
> 
> -A patch by Darrick Wong that adds a set of rudimentary IPMI tests to 
> pounder.  They check that the in-kernel IPMI driver can access the 
> machine's BMC/SP (if there is one), query it for status and check for 
> various IPMI 2.0 features.
> default-tests.tar.gz,
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



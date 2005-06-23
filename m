Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVFWGhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVFWGhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFWGhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:37:06 -0400
Received: from fra-del-02.spheriq.net ([195.46.51.98]:34273 "EHLO
	fra-del-02.spheriq.net") by vger.kernel.org with ESMTP
	id S262301AbVFWGSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:50 -0400
From: N Chandra Shekhar REDDY <ncs.reddy@st.com>
To: "'J.A. Magallon'" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cpu utilization per thread
Date: Thu, 23 Jun 2005 11:48:31 +0530
Message-ID: <083301c577bb$6264a580$99bcc68a@blr.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.5709
In-Reply-To: <1119403875l.7816l.1l@werewolf.able.es>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
X-O-General-Status: No
X-O-Spam1-Status: Not Scanned
X-O-Spam2-Status: Not Scanned
X-O-URL-Status: Not Scanned
X-O-Virus1-Status: No
X-O-Virus2-Status: Not Scanned
X-O-Virus3-Status: No
X-O-Virus4-Status: No
X-O-Virus5-Status: Not Scanned
X-O-Image-Status: Not Scanned
X-O-Attach-Status: Not Scanned
X-SpheriQ-Ver: 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.
I have tried with getrusage it is giving zero as the result. 
I have found one more method(using setitimer(ITIMER_PROF,&enc_timer,NULL);
and signal SIGPROF) which will give the user and system time of a process. 
Is it applicable for the thread?
Does this method give the expected results for thread?
--ncs     


-----Original Message-----
From: J.A. Magallon [mailto:jamagallon@able.es] 
Sent: Wednesday, June 22, 2005 7:01 AM
To: N Chandra Shekhar REDDY
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cpu utilization per thread



On 06.21, N Chandra Shekhar REDDY wrote:
> Hi all,
> Can any body tell me
> How to find cpu utilization per thread excluding wait times and sleep
times?
> Regards
> ncs
> 

man getrusage.

Pay special attention to the RUSAGE_SELF or RUSAGE_CHILDREN
flag, but I think current linux kernel does not perform a correct account
for threads rusage in the parent. Probably you will have to account each
thread, return info to the parent and sum or average (sum cpu times,
average elapsed times...)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like
sex:
werewolf!able!es                         \         It's better when it's
free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release
2006.0))




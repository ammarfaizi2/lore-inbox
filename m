Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318848AbSHWOls>; Fri, 23 Aug 2002 10:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318849AbSHWOls>; Fri, 23 Aug 2002 10:41:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48801 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318848AbSHWOlp>;
	Fri, 23 Aug 2002 10:41:45 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: haveblue@us.ibm.com
Cc: Benjamin LaHaise <bcrl@redhat.com>, alan@lxorguk.ukuu.org.uk,
       "Bill Hartner" <bhartner@us.ibm.com>, davem@redhat.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF1AAF39E9.D733B26C-ON87256C1E.004ACC87@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Fri, 23 Aug 2002 09:44:23 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/23/2002 08:44:26 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dave Hansen wrote..
>Mala Anand wrote:
>> The third scope would be measuring this patch in a workload environment.
>> We measured it in a web serving workload and found that we get 0.7%
>> improvement.

>First of all, the patch doesn't apply at all against the current
>bitkeeper tree.  I can post the exact one I used if you like.

>I tried this under our Specweb99 setup.  Here's a snippet of
>readprofile with, then without the patch:

>alloc:free ratio: 1.226
>(__kfree_skb+alloc_skb)/total = 3.14%


>alloc:free ratio: 0.348
>(__kfree_skb+alloc_skb)/total = 2.79%

>You can see the entire readprofile here:
>http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap-08-22-2002-11.20.17/

>http://www.sr71.net/~specweb99/run-specweb-100sec-2400-2.5.31-bk+4-kmap-mala-08-22-2002-11.44.25/

>No, I don't know why I have so much idle time.

Readprofile ticks are not as accurate as the cycles I measured.
Moreover readprofile can give misleading information as it profiles
on timer interrupts. The alloc_skb and __kfree_skb call memory
management routines and interrupts are disabled in many parts of that code.
So I don't trust the readprofile data.



Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088





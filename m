Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVESONk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVESONk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVESONj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:13:39 -0400
Received: from [194.90.79.130] ([194.90.79.130]:7437 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262508AbVESONd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:13:33 -0400
Subject: Re: why nfs server delay 10ms in nfsd_write()?
From: Avi Kivity <avi@argo.co.il>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Peter Staubach <staubach@redhat.com>, steve <lingxiang@huawei.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
In-Reply-To: <1116511140.21587.4.camel@mindpipe>
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>
	 <1116472423.11327.1.camel@mindpipe>  <428C8C32.2030803@redhat.com>
	 <1116511140.21587.4.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 19 May 2005 17:13:29 +0300
Message-Id: <1116512010.9340.4.camel@blast.qumranet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2005 14:13:31.0978 (UTC) FILETIME=[EFDBB2A0:01C55C7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 09:59 -0400, Lee Revell wrote:
> On Thu, 2005-05-19 at 08:53 -0400, Peter Staubach wrote:
> > There are certainly many others way to get gathering, without adding an
> > artificial delay.  There are already delay slots built into the code 
> > which could
> > be used to trigger the gathering, so with a little bit different 
> > architecture, the
> > performance increases could be achieved.
> > 
> > Some implementations actually do write gathering with NFSv3, even.  Is
> > this interesting enough to play with?  I suspect that just doing the 
> > work for
> > NFSv2 is not...
> 
> Also, how do you explain the big performance hit that steve observed?
> Write gathering is supposed to help performance, but it's a big loss on
> his test...
> 

that would depend on the NFS client and the application. for example, if
the NFS client has no (or low) concurrency, then write gathering would
reduce preformance.




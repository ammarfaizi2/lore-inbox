Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVETNIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVETNIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVETNIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:08:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35725 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261456AbVETNIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:08:13 -0400
Message-ID: <428DE0A2.5070107@redhat.com>
Date: Fri, 20 May 2005 09:05:38 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: steve <lingxiang@huawei.com>
CC: Lee Revell <rlrevell@joe-job.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
Subject: Re: why nfs server delay 10ms in nfsd_write()?
References: <0IGS00FKJBCKRE@szxml02-in.huawei.com>
In-Reply-To: <0IGS00FKJBCKRE@szxml02-in.huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

steve wrote:

>Hi Peter,
>My envionment looks like that:
>
>NFS Server：Suse9 Enterprise 
>NFS Client：Redhat AS3.0(kernel 2.4.21) 
>
>I made a ramdisk and export it with nfs
>Server and Client are connected with 1000Mbps
>
>mount the ramdisk on the client with parameters: -t nfs -o rw,noac
>
>then test with iometer and the parameters are: 
>Outstanding IO is 32, transfer request size is 512, sequential write
>the result is about 300KB/s, iops is about 600
>
>with dd test i find the delay most cost at the server.
>
>i agree with Avi that "if the NFS client has no (or low) concurrency, then write gathering would reduce preformance"
>

I would agree too with Avi, and especially in this configuration...

I think that we could construct a writer gathering implementation which 
did not
show measurable performance impact in this sort of situation though still.

Thanx...

ps

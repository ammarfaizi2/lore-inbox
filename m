Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVDAQTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVDAQTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVDAQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:19:05 -0500
Received: from main.gmane.org ([80.91.229.2]:27614 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262788AbVDAQSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:18:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Re: NFS client latencies
Date: Fri, 01 Apr 2005 09:16:35 -0700
Message-ID: <d2js2h$v74$1@sea.gmane.org>
References: <20050331065942.GA14952@elte.hu> <20050330231801.129b0715.akpm@osdl.org> <20050331073017.GA16577@elte.hu> <1112270304.10975.41.camel@lade.trondhjem.org> <1112272451.10975.72.camel@lade.trondhjem.org> <20050331135825.GA2214@elte.hu> <1112279522.20211.8.camel@lade.trondhjem.org> <20050331143930.GA4032@elte.hu> <20050331145015.GA4830@elte.hu> <1112322516.2509.28.camel@mindpipe> <20050401043022.GA22753@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
In-Reply-To: <20050401043022.GA22753@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
>>This fixes all the NFS related latency problems I was seeing.  Now the 
>>longest latency from an NFS kernel compile with "make -j64" is 391 
>>usecs in get_swap_page.
> 
> 
> great! The latest patches (-42-08 and later) have the reworked 
> nfs_scan_list() lock-breaker, which should perform similarly.
> 
> i bet these NFS patches also improve generic NFS performance on fast 
> networks. I've attached the full patchset with all fixes and 
> improvements included - might be worth a try in -mm?
> 

Just a question - would these changes be expected to improve NFS client 
*read* access at all, or just write?

Thanks!


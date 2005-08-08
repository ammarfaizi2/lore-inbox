Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVHHPhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVHHPhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 11:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVHHPhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 11:37:38 -0400
Received: from [194.90.79.130] ([194.90.79.130]:5899 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1750938AbVHHPhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 11:37:37 -0400
Message-ID: <42F77C3B.20900@argo.co.il>
Date: Mon, 08 Aug 2005 18:37:31 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Janak Desai <janak@us.ibm.com>, viro@parcelfarce.linux.theplanet.co.uk,
       sds@tycho.nsa.gov, linuxram@us.ibm.com, ericvh@gmail.com,
       dwalsh@redhat.com, jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org,
       gh@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] New system call, unshare
References: <Pine.WNT.4.63.0508080928480.3668@IBM-AIP3070F3AM> <1123512366.31229.8.camel@localhost.localdomain>
In-Reply-To: <1123512366.31229.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2005 15:37:33.0358 (UTC) FILETIME=[1836FCE0:01C59C2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2005-08-08 at 09:33 -0400, Janak Desai wrote:
>  
>
>>[PATCH 1/2] unshare system call: System Call handler function sys_unshare
>>    
>>
>
>
>Given the complexity of the kernel code involved and the obscurity of
>the functionality why not just do another clone() in userspace to
>unshare the things you want to unshare and then _exit the parent ?
>
>  
>
suppose somebody wait()s for the parent? you've turned a synchronous 
operation into an asynchronous one.

Return-Path: <linux-kernel-owner+w=401wt.eu-S1751627AbWLVXqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWLVXqj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 18:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbWLVXqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 18:46:39 -0500
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:59941 "EHLO
	post-25.mail.nl.demon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbWLVXqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 18:46:38 -0500
Message-ID: <458C6E56.3070700@edsons.demon.nl>
Date: Sat, 23 Dec 2006 00:46:30 +0100
From: Rudy Zijlstra <rudy@edsons.demon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7.12) Gecko/20050923
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <Trond.Myklebust@netapp.com>,
       nfs <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Kernel BUG
References: <458BC8AE.2030507@edsons.demon.nl> <1166794920.32117.42.camel@twins>
In-Reply-To: <1166794920.32117.42.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:

>On Fri, 2006-12-22 at 12:59 +0100, Rudy Zijlstra wrote:
>  
>
>>Hi,
>>
>>I have a system where whenever i trigger a ongoing consistent NFS load i 
>>get the following kernel BUG:
>>
>>----------
>>kernel BUG at mm/truncate.c:311!
>>    
>>
>
>Lotsa changes there:
>try these:
> http://client.linux-nfs.org/Linux-2.6.x/2.6.19/linux-2.6.19-NFS_ALL.dif
>
>And:
>  http://lkml.org/lkml/2006/12/19/279
>
>  
>
Thanks, i have now a 2.6.19.1 patched with the above NFS_ALL patchset 
running under load since about 17:00 and still going strong. So seems to 
have solved the problem!

Also, performance seems to have significantly increased. I am testing 
this with MythTv with the storage over NFS. With HD LiveTV (which  is 
what i use to test this), this translates into about 43Mbps total load, 
from almost 15Mbps video stream which is present 3x on the ethernet:
1/ from card to NFS disk
2/ read from NFS disk
3/ stream to viewer app.

Doing this with HD streams before the patch set resulted in regular 
picture hickups. No hickups visible anymore (that i have seen, i have 
not been present all this time).

Regards,

Rudy

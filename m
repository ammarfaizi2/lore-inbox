Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUA3CLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 21:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266591AbUA3CLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 21:11:45 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:26006 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S266572AbUA3CLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 21:11:43 -0500
Message-ID: <4019BD48.60905@hanaden.com>
Date: Thu, 29 Jan 2004 20:11:20 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Mike Fedyk <mfedyk@matchmail.com>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] NFS rpc and stale handles on 2.6.x servers
References: <4014675D.2040405@hanaden.com>	<16409.43367.545322.356713@notabene.cse.unsw.edu.au>	<20040130012534.GE2445@srv-lnx2600.matchmail.com> <16409.46352.877421.233677@notabene.cse.unsw.edu.au>
In-Reply-To: <16409.46352.877421.233677@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add this to your exportfs "no_subtree_check"  It seems to be a temp 
workaround.  Searching the web, the only issue with this option seems to 
be a minor performance hit (big issue for large systems).  Any chance of 
getting the patch 2.6.2?  www.kernel.org looks like its still on an RC2 
of this.


Neil Brown wrote:
> On Thursday January 29, mfedyk@matchmail.com wrote:
> 
>>On Fri, Jan 30, 2004 at 11:46:31AM +1100, Neil Brown wrote:
>>
>>>On Sunday January 25, hanasaki@hanaden.com wrote:
>>>
>>>>The below is being reported, on and off, when hitting nfs-kernel-servers
>>>>running on 2.6.0 and 2.6.1  Could someone tell me if this is smoe bug or
>>>>what?  Thanks
>>>>	RPC request reserved 0 but used 124
>>>>
>>>>Debian sarge
>>>>nfs-kernel-server
>>>>am-untils
>>>>nfsv3 over tcp
>>>>
>>>
>>>stale file handles is a known bug that is fixed in the but BK and will
>>>be in 2.6.3.
>>
>>do you mean 2.6.2?
> 
> 
> Yeh, 2.6.2 as well.. But definitely 2.6.3 :-)
> 
> 
>>I've merged the nfsd stale file handles into 2.6.1-bk2 and it is working
>>fine on a nfs server here...
> 
> 
> good, thanks.
> NeilBrown

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWCPVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWCPVhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 16:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWCPVhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 16:37:23 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:2997 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932685AbWCPVhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 16:37:22 -0500
Message-ID: <4419DA6D.7050800@us.ibm.com>
Date: Thu, 16 Mar 2006 16:36:45 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before
 we are committed.
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com> <20060316123341.0f55fd07.akpm@osdl.org>
In-Reply-To: <20060316123341.0f55fd07.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ebiederm@xmission.com (Eric W. Biederman) wrote:
>  
>
>>Since we have not crossed the magic 2.6.16 line can we please
>> include this patch.  My apologies for catching this so late in the
>> cycle.
>>
>> - Error if we are passed any flags we don't expect.
>>
>>   This preserves forward compatibility so programs that use new flags that
>>   run on old kernels will fail instead of silently doing the wrong thing.
>>    
>>
>
>Makes sense.
>
>  
>
>> - Use separate defines from sys_clone.
>>
>>   sys_unshare can't implement half of the clone flags under any circumstances
>>   and those that it does implement have subtlely different semantics than
>>   the clone flags.  Using a different set of flags sets the
>>   expectation that things will be different.
>>    
>>
>
>iirc there was some discussion about this and it was explicitly decided to
>keep the CLONE flags.
>
>Maybe Janak or Linus can comment?
>
>  
>
In the two prior discussions on this, the disagreement was on how much 
confusion
(if any) the use of CLONE_* flags would generate. I personally did not 
think that
it was confusing enough to add new flags, with the same values as CLONE_*
flags, in the kernel. Linus's last email (3/1/06) on the subject seemed 
to lean in that
direction as well. That's why I didn't take any action on it.

-Janak


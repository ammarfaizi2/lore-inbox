Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWCUVws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWCUVws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWCUVws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:52:48 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:31619 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751450AbWCUVwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:52:47 -0500
Message-ID: <442075A1.8020508@vilain.net>
Date: Wed, 22 Mar 2006 09:52:33 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 1/7] Add process virtualisation umbrella	structure
 (vx_info)
References: <20060321061333.27638.63963.stgit@localhost.localdomain>	 <20060321061333.27638.9112.stgit@localhost.localdomain> <1142967185.10906.188.camel@localhost.localdomain>
In-Reply-To: <1142967185.10906.188.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>On Tue, 2006-03-21 at 18:13 +1200, Sam Vilain wrote:
>  
>
>>+static inline void release_vx_info(struct vx_info *vxi,
>>+       struct task_struct *task)
>>+{
>>+       might_sleep();
>>+
>>+       if (atomic_dec_and_test(&vxi->vx_tasks))
>>+               unhash_vx_info(vxi);
>>+} 
>>    
>>
>
>Are these better handled by krefs and their destructors?
>  
>

It does seem a little clumsy, doesn't it.  I've found
Documentation/kref.txt and will rewrite those functions to use this API.

Sam.

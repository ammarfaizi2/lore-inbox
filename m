Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVD2VJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVD2VJG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVD2VHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:07:52 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:44017 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262979AbVD2VFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:05:19 -0400
Message-ID: <4272A181.8080504@austin.rr.com>
Date: Fri, 29 Apr 2005 16:05:05 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: which ioctls matter across filesystems
References: <42728964.8000501@austin.rr.com> <1114804426.12692.49.camel@lade.trondhjem.org> <1114805033.6682.150.camel@betsy> <1114807360.12692.77.camel@lade.trondhjem.org> <42729F4F.2020209@austin.rr.com> <1114808272.6682.158.camel@betsy>
In-Reply-To: <1114808272.6682.158.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>On Fri, 2005-04-29 at 15:55 -0500, Steve French wrote:
>
>  
>
>>I believe that the spotlight facility of MacOS, and the somewhat similar 
>>Longhorn feature (think Google desktop search/indexing on steroids) 
>>qualify as killer-apps.   I am concerned about how to do better with our 
>>implementations across a distributed (NFS, CIFS etc.) network.   And of 
>>course coalescing async notifications most efficiently is a fascinating 
>>and difficult area to do right - for servers at least.
>>    
>>
>
>If we had some way to efficiently coalesce events, even non-remote stuff
>would drool.  Beagle (our Spotlight killer) would love it.
>
>First thing is, the events cannot be stored in a linked list. ;-)
>
>	Robert Love
>  
>
I should mention one obvious thing - there can be two wire protocols 
here (at least for the CIFS case) - an optimized case which matches -- 
exactly -- to the [better] new semantics that Linux allows and the 
interoperability case (which can be less efficient) ie
the existing Transact2 NOTIFY mechanism which is widely supported by 
current servers and currently defined in fs/cifs/cifspdu.h

I don't mind, nor do others on the Samba team, extending the wire 
protocol for CIFS where it would help that - "killer app" as long as it is
    - optional
    - persuasive benefit
    - helps the network case to better match the -- exact -- local 
semantics applications would expect.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbULIQ40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbULIQ40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbULIQzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:55:37 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:59372 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S261551AbULIQxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:53:46 -0500
Message-ID: <41B88319.9070207@mnsu.edu>
Date: Thu, 09 Dec 2004 10:53:45 -0600
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Limin Gu <limin@dbear.engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job kernel/user
 interface
References: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com> <20041209140504.GD5187@lnx-holt.americas.sgi.com>
In-Reply-To: <20041209140504.GD5187@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd have to second Robin's sentiments.  IMHO there should be a very 
strong reason to have this type of information in a new filesystem as 
this type of proliferation is counterproductive.

-- 
jeffrey hundstad

Robin Holt wrote:

>On Wed, Dec 08, 2004 at 02:03:21PM -0800, Limin Gu wrote:
>  
>
>>Hello,
>>
>>I am looking for your comments on the attached draft, it is the job patch 
>>for 2.6.9. I have posted job patch for older kernel before, but in this patch
>>I have replaced the /proc/job binary ioctl calls with a new small virtual 
>>filesystem (jobfs).
>>
>>Job uses the hook provided by PAGG (Process Aggregates). A job is a group
>>related processes all descended from a point of entry process and identified
>>by a unique job identifier (jid). You can find the general information
>>about PAGG and Job at http://oss.sgi.com/projects/pagg/
>>
>>I will very much appreciate your comments, suggestions and criticisms
>>on this new filesystem design and implementation as the job kernel/user
>>communication interface. The patch is still a draft.
>>
>>Thank you!
>>    
>>
>
>I maintain my position that this belongs in /proc.
>
>Why not have a structure something like:
>
>/proc/<pid>/job -> ../jobs/<jid>
>/proc/jobs/<jid>/<pid> -> ../../<pid>
>
>What other information is really necessary from userland?
>
>  
>

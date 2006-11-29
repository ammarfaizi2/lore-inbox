Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935957AbWK2R7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935957AbWK2R7T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 12:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935976AbWK2R7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 12:59:19 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:21447 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S935957AbWK2R7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 12:59:18 -0500
Message-ID: <456DCA6A.9000903@fr.ibm.com>
Date: Wed, 29 Nov 2006 18:59:06 +0100
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dmitry Mishin <dim@openvz.org>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch -mm] net namespace: empty framework
References: <4563007B.9010202@fr.ibm.com> <200611221955.56942.dim@openvz.org>	<20061123023943.GA22931@sergelap.austin.ibm.com> <200611231207.40634.dim@openvz.org>
In-Reply-To: <200611231207.40634.dim@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Mishin wrote:
> On Thursday 23 November 2006 05:39, Serge E. Hallyn wrote:
>> Quoting Dmitry Mishin (dim@openvz.org):
>>> On Wednesday 22 November 2006 19:41, Serge E. Hallyn wrote:
>>>> Quoting Cedric Le Goater (clg@fr.ibm.com):
>>>>> Hello,
>>>>>
>>>>> Dmitry Mishin wrote:
>>>>>> This patch looks acceptable for us.
>>>>> good. shall we merge it then ? see comment below.
>>>>>
>>>>>> BTW, Daniel, we agreed to be based on the Andrey's patchset. I do
>>>>>> not see a reason, why Cedric force us to make some unnecessary work
>>>>>> and move existent patchset over his interface.
>>>>> yeah it's a bit different from andrey's but not that much and it's
>>>>> more in
>>>> Where is Andrey's patch?
>>> This thread - http://thread.gmane.org/gmane.linux.network/42666
>> Thanks, Dmitry.  Now I do recall seeing that before.
>>
>> That patchset appears to go part, but not all the way to fitting in with
>> the existing namespaces.  For instance, you use exit_task_namespaces() for
>> refcounting, but don't put the net_namespace in the nsproxy and use your
>> own mechanism for unsharing.
>>
>> It really seems useful to have all the namespaces be consistent whenever
>> practical, and I don't think your patchset would need much tweaking to
>> fit onto Cedric's patch.  Am I missing a complicating factor?
> No. I've already said, Cedric's patch is acceptable for us.

Do you mind if we port your patchset on top of this patch ? If you have 
no time for that I can do it.

  -- Daniel

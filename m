Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDEAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDEAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDEAV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:21:27 -0400
Received: from dvhart.com ([64.146.134.43]:48069 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751026AbWDEAV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:21:26 -0400
Message-ID: <44330D7F.3070109@mbligh.org>
Date: Tue, 04 Apr 2006 17:21:19 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, ebiederm@xmission.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>	<20060404162921.GK6529@stusta.de>	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>	<4432B22F.6090803@vmware.com>	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>	<4432C7AC.9020106@vmware.com>	<20060404132546.565b3dae.akpm@osdl.org>	<4432ECF1.8040606@vmware.com> <20060404151904.764ad9f4.akpm@osdl.org>
In-Reply-To: <20060404151904.764ad9f4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I don't recall anyone expressing any desire for the ability to set these
>>>things at runtime.  Unless there is such a requirement I'd suggest that the
>>>best way to address Eric's point is to simply rename the relevant functions
>>>from foo() to subarch_foo().
>>>  
>>
>>Avoiding the runtime assignment isn't possible if you want a generic 
>>subarch that truly can run on multiple different platforms.
> 
> Well as I said - I haven't seen any requirement for this expressed.  That
> doesn't mean that such a requirements doesn't exist, of course.

I think there is a real requirement to do this at boot-time, yes. We 
don't want a proliferation of different kernel builds in distros,
but one kernel that installs and boots everywhere (think installer
kernels on boot CDs, etc ... plus testing requirements). Autoswitching,
without magic user-flags. That's what the generic subarch was always
for, and frankly the others all ought to die (apart from possibly really
specialised non-mainstream stuff like voyager and NUMA-Q).

M.

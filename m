Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDECqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDECqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 22:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWDECqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 22:46:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56467 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750722AbWDECqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 22:46:43 -0400
To: Martin Bligh <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de>
	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>
	<4432B22F.6090803@vmware.com>
	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>
	<4432C7AC.9020106@vmware.com> <20060404132546.565b3dae.akpm@osdl.org>
	<4432ECF1.8040606@vmware.com> <20060404151904.764ad9f4.akpm@osdl.org>
	<44330D7F.3070109@mbligh.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 20:45:21 -0600
In-Reply-To: <44330D7F.3070109@mbligh.org> (Martin Bligh's message of "Tue,
 04 Apr 2006 17:21:19 -0700")
Message-ID: <m1zmj0ivum.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@mbligh.org> writes:

>>>>I don't recall anyone expressing any desire for the ability to set these
>>>>things at runtime.  Unless there is such a requirement I'd suggest that the
>>>>best way to address Eric's point is to simply rename the relevant functions
>>>>from foo() to subarch_foo().
>>>>
>>>
>>> Avoiding the runtime assignment isn't possible if you want a generic subarch
>>> that truly can run on multiple different platforms.
>> Well as I said - I haven't seen any requirement for this expressed.  That
>> doesn't mean that such a requirements doesn't exist, of course.
>
> I think there is a real requirement to do this at boot-time, yes. We don't want
> a proliferation of different kernel builds in distros,
> but one kernel that installs and boots everywhere (think installer
> kernels on boot CDs, etc ... plus testing requirements). Autoswitching,
> without magic user-flags. That's what the generic subarch was always
> for, and frankly the others all ought to die (apart from possibly really
> specialised non-mainstream stuff like voyager and NUMA-Q).

Plus it is pretty simple if you compile for a single architecture to
kill the function pointers.  That is how the alpha is currently structured.

So for the people who don't want it switchable the code can just compile
out.

Getting this infrastructure now before i386 becomes primarily and embedded
architecture will be nice.

Eric

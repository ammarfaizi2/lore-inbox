Return-Path: <linux-kernel-owner+w=401wt.eu-S1750973AbXAPTFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXAPTFO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbXAPTFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:05:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42506 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXAPTFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:05:12 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<45AD02FF.605@zytor.com> <m164b6den7.fsf@ebiederm.dsl.xmission.com>
	<45AD1AD7.7030804@zytor.com>
	<m1ac0iby5q.fsf@ebiederm.dsl.xmission.com>
	<45AD2042.9090701@zytor.com>
Date: Tue, 16 Jan 2007 12:03:36 -0700
In-Reply-To: <45AD2042.9090701@zytor.com> (H. Peter Anvin's message of "Tue,
	16 Jan 2007 10:58:10 -0800")
Message-ID: <m164b6bxpz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>>>>
>>> With "architectural" I mean "guaranteed to be stable" (as opposed to
>>> "incidental").  Sorry for the confusion.
>>
>> Ok.  Then largely we are in agreement.  To implement that the rule is simple.
>> If it isn't CTL_UNNUMBERED and the number is in Linus's tree, it is
>> our responsibility to never change the meaning of that number.
>>
>> If a new sysctl entry is introduced it should be CTL_UNNUMBERED until
>> it reaches Linus's tree to avoid conflicts.
>>
>> There is simply no point in having any kind of support for numbers
>> whose meanings can change.
>>
>> Which is why I removed the few cases of binary number duplication I
>> found.
>>
>
> Agreed.  *Furthermore*, if the number isn't in <linux/sysctl.h> it shouldn't
> exist anywhere else, either.

That would be a good habit.  Feel free to send the patches to ensure that
is so.

I'm a practical fix it when it is in my way kind of guy ;)

Eric

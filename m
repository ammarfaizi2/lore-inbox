Return-Path: <linux-kernel-owner+w=401wt.eu-S1751021AbXAPS6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbXAPS6q (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbXAPS6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:58:34 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47028 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXAPS6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:58:32 -0500
Message-ID: <45AD2042.9090701@zytor.com>
Date: Tue, 16 Jan 2007 10:58:10 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>	<45AD02FF.605@zytor.com> <m164b6den7.fsf@ebiederm.dsl.xmission.com>	<45AD1AD7.7030804@zytor.com> <m1ac0iby5q.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac0iby5q.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>>>
>> With "architectural" I mean "guaranteed to be stable" (as opposed to
>> "incidental").  Sorry for the confusion.
> 
> Ok.  Then largely we are in agreement.  To implement that the rule is simple.
> If it isn't CTL_UNNUMBERED and the number is in Linus's tree, it is
> our responsibility to never change the meaning of that number.
> 
> If a new sysctl entry is introduced it should be CTL_UNNUMBERED until
> it reaches Linus's tree to avoid conflicts.
> 
> There is simply no point in having any kind of support for numbers
> whose meanings can change.
> 
> Which is why I removed the few cases of binary number duplication I
> found.
> 

Agreed.  *Furthermore*, if the number isn't in <linux/sysctl.h> it 
shouldn't exist anywhere else, either.

	-hpa


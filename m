Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUJNOAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUJNOAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUJNOAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:00:40 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:36802 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264246AbUJNOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:00:37 -0400
Message-ID: <416E8779.3020303@shadowconnect.com>
Date: Thu, 14 Oct 2004 16:04:41 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: question about MTRR areas on x86_64
References: <2M5w2-y8-3@gated-at.bofh.it>	<m3vfdox14o.fsf@averell.firstfloor.org> <m1acupefrn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1acupefrn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Eric W. Biederman wrote:
> Andi Kleen <ak@muc.de> writes:
>>Markus Lidel <Markus.Lidel@shadowconnect.com> writes:
>>>Could it be because the machine has too much memory, or is there a bug in the
>>I2O driver?
>>
>>The problem comes from the BIOS who set up reg00 to be overlapping
>>over other areas. The Linux MTRR driver cannot deal with overlapping
>>MTRRs, in fact it is sometimes impossible because it could run
>>out of registers or violate some of the MTRR restrictions.

Sorry, for not answering, but somehow i never received your e-mail. :-(

> And the BIOS is using overlapping MTRRs because otherwise it would run
> out.

Okay...

>>It's a long standing problem, eventual fix will be to get rid
>>of MTRRs completely and only use PAT. But it needs a bit more work.

I've seen there is already a patch around to add initial PAT support. So 
i think it's only a question of time until it is included :-D If there is 
something i could help with please let me know.

Thanks to both of you for helping.



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

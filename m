Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVCPFfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVCPFfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCPFfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:35:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:50123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262528AbVCPFe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:34:57 -0500
Message-ID: <4237C473.2060205@osdl.org>
Date: Tue, 15 Mar 2005 21:30:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Taking strlen of buffers copied from userspace
References: <3IugU-2m4-11@gated-at.bofh.it> <3IugU-2m4-9@gated-at.bofh.it> <3IykC-5x0-29@gated-at.bofh.it> <4237C2F2.5010203@shaw.ca>
In-Reply-To: <4237C2F2.5010203@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Randy.Dunlap wrote:
> 
>> The latter one does (before the listed code):
>>
>>     memset(line, 0, LINE_SIZE);
>>     if (len > LINE_SIZE)
>>         len = LINE_SIZE;
>>     if (copy_from_user(line, buf, len - 1))
>>         return -EFAULT;
>>
>> so isn't line[LINE_SIZE - 1] always 0 ?
> 
> 
> In that case, yes (I hadn't looked at the surrounding code). Rather an 
> odd way of doing it, but shouldn't have that problem. Could still be 
> subject to problems if buf contains a null at the first character, 
> unless they're somehow preventing that too..

Yes, that's still a problem.

-- 
~Randy

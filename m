Return-Path: <linux-kernel-owner+w=401wt.eu-S1751171AbXAII31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXAII31 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbXAII31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:29:27 -0500
Received: from relay.gothnet.se ([82.193.160.251]:4998 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751171AbXAII30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:29:26 -0500
Message-ID: <45A3521A.1080103@tungstengraphics.com>
Date: Tue, 09 Jan 2007 09:28:10 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060921)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: davej@redhat.com, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@gmail.com>
Subject: Re: agpgart: drm-populated memory types
References: <1166533877.3365.1244.camel@laptopd505.fenrus.org>	 <11682488182899-git-send-email-thomas@tungstengraphics.com> <1168310231.3180.80.camel@laptopd505.fenrus.org>
In-Reply-To: <1168310231.3180.80.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Mail not scanned due to license constraints
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> A short recap why I belive the kmalloc / vmalloc construct is necessary:
>>
>> 0) The current code uses vmalloc only.
>> 1) The allocated area ranges from 4 bytes possibly up to 512 kB, depending on
>> on the size of the AGP buffer allocated.
>> 2) Large buffers are very few. Small buffers tend to be quite many. 
>>    If we continue to use vmalloc only or another page-based scheme we will
>>    waste approx one page per buffer, together with the added slowness of
>>    vmalloc. This will severely hurt applications with a lot of small
>>    texture buffers.
>>
>> Please let me know if you still consider this unacceptable.
>>     
>
> explicit use of either kmalloc/vmalloc is fine with me; I would suggest
> an 2*PAGE_SIZE cutoff for this decision
>
>   
>>  
>> In that case I suggest sticking with vmalloc for now.
>>
>> Also please let me know if there are other parths of the patch that should be
>> reworked.
>>
>> The patch that follows is against Dave's agpgart repo.
>>
>>     
> <you forgot the patch>
>
>   
Hmm.
Still struggling with git-send-email.
Now it should have arrived.

Thanks,
Thomas





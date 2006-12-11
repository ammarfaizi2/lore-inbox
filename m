Return-Path: <linux-kernel-owner+w=401wt.eu-S936337AbWLKPIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936337AbWLKPIF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936389AbWLKPIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:08:05 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:40374 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S936337AbWLKPIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:08:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZHG0OCjYNucabnDyRaKzwWuwphcFlpIw10w4X5RjcF/HtRZ1/K6gFw8ogDgxh6oN4Ut5bkwySl3LNHb5I/g08s6S9Bzy2lrnkdK1jE1KagOZF1X5cYnDAqIKveA/wBFlNbIl/yJoMt6weZrlU6fvBFKfqJSM0Xk2n8caKrVhRR4=  ;
X-YMail-OSG: PLijtm8VM1kjSbJp_bOAQE0.te2_T77MXHC3naYoaWUg56F9d4oICdT5XGiYsxHdAxVbHUhHHFBmVjJsO202ZFdgECN_eWRurb2WTRSYzsGPdfv4LiaswOD_hWBNo1oTWlBWL1ZEkbFgJ_cDR2t9TW_TUQGvBCVILQ--
Message-ID: <457D741F.6070108@yahoo.com.au>
Date: Tue, 12 Dec 2006 02:07:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jiri Kosina <jikos@jikos.cz>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1
References: <20061211005807.f220b81c.akpm@osdl.org> <Pine.LNX.4.64.0612111137360.1665@twin.jikos.cz> <457D6B10.4010903@yahoo.com.au> <Pine.LNX.4.64.0612111532370.1665@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0612111532370.1665@twin.jikos.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina wrote:
> On Tue, 12 Dec 2006, Nick Piggin wrote:
> 
> 
>>>Am I the only one seeing something strange on ext3 with this kernel? 
>>>For example /etc/resolv.conf gets corrupted during the dhclient run. 
>>>It looks like this, after dhclient finishes:
>>
>>Do you have CONFIG_DEBUG_VM turned on? I think we miss clearning BH_New
>>in some places, thus causing an error path to zero the block incorrectly
>>if we hit an error that CONFIG_DEBUG_VM makes much more likely.
> 
> 
> Yes, I have. Will retry without it and let you know if the problem goes 
> away.

Thanks.

> Seems quite dangerous, a few minutes with 2.6.19-mm1 corrupted quite a lot 
> of files on my fs.

Sorry.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

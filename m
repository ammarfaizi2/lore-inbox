Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTJPPRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 11:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTJPPRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 11:17:14 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:60874 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262994AbTJPPRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 11:17:12 -0400
Message-ID: <3F8EB59B.2040400@colorfullife.com>
Date: Thu, 16 Oct 2003 17:13:31 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: wli@holomorphy.com, albertogli@telpin.com.ar, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
References: <20031016025554.GH4292@telpin.com.ar>	<20031015211918.1a70c4d2.akpm@osdl.org>	<20031016044334.GE4461@holomorphy.com>	<20031015215824.165dc4c7.akpm@osdl.org>	<3F8E2F68.7010007@colorfullife.com> <20031015233102.05eb809b.akpm@osdl.org>
In-Reply-To: <20031015233102.05eb809b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Manfred Spraul <manfred@colorfullife.com> wrote:
>  
>
>>I've attached something: with the patch applied, `echo "size-4096 0 0 0" 
>>  > /proc/slabinfo` dumps all caller addresses.
>>    
>>
>
>Awesome, thanks.
>
>I added some tweaks (why was it returning -EINVAL?).
>
>Is there any reason why we shouldn't merge this up?
>  
>
It works only on 32-archs, and I had to disable the double-free 
detection - the bufctl integers were already in use (the hunk with the 
#if 0) for that.


--
    Manfred




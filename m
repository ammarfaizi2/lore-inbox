Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVCFWu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVCFWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCFWqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:46:47 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:3262 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261589AbVCFWnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:43:11 -0500
Message-ID: <422B8778.6040401@acm.org>
Date: Sun, 06 Mar 2005 16:43:04 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Bene Martin <martin.bene@icomedias.com>, minyard@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] readd ipmi_request
References: <FA095C015271B64E99B197937712FD02510ACF@freedom.grz.icomedias.com> <20050305180346.GF6373@stusta.de>
In-Reply-To: <20050305180346.GF6373@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Sat, Mar 05, 2005 at 10:41:31AM +0100, Bene Martin wrote:
>
>  
>
>>Hi Adrian,
>>
>>bmcsensors package (reading hardware sensors provided by intel boards
>>via ipmi) used to work fine with 2.6.10; no longer works with 2.6.11
>>because of removal of the ipmi_request function (+ exported symbol).
>>
>>correct fix would be to use ipmi_request_settime with retries=-1 and
>>retry_time_ms=0?
>>    
>>
>
>I didn't know about this, the patch below readds ipmi_request.
>  
>
IMHO, it's probably better to modify your patch to use 
ipmi_request_settime.  That function is there is all recent kernels.  
Unfortunately, I can't magically re-add the ipmi_request function to 
2.6.11, and it would be less confusing to have a new patch for 
bmcsensors that worked with stock 2.6.11.

Again, sorry about this.

-Corey

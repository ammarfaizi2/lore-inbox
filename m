Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTE2SJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 14:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTE2SJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 14:09:56 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:51882 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262482AbTE2SJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 14:09:55 -0400
Message-Id: <200305291810.h4TIAdsG024042@ginger.cmf.nrl.navy.mil>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Thu, 29 May 2003 13:21:26 -0300."
             <20030529162125.GU24054@conectiva.com.br> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 29 May 2003 14:08:59 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030529162125.GU24054@conectiva.com.br>,Arnaldo Carvalho de Melo w
rites:
>> @@ -1067,46 +1044,39 @@
>>  	 */
>>  
>>  	/* 4.3 pci bus controller-specific initialization */
>> -	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0)
>> -	{
>> +	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0) {
>>  		hprintk("can't read GEN_CNTL_0\n");
>
>Humm, shouldn't we release the irq here? What about using gotos for exception
>handing?

what irq?  the irq is grabbed in he_init_irq.  if he_start() fails, we 
call he_stop() and it frees the irq.


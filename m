Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVCIRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVCIRfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVCIRdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:33:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:40151 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262123AbVCIRcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:32:01 -0500
Message-ID: <422F330F.9080200@us.ltcfwd.linux.ibm.com>
Date: Wed, 09 Mar 2005 12:31:59 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Scott_Kilau@digi.com, linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com> <4228CE5C.9010207@us.ltcfwd.linux.ibm.com> <20050305064445.GA8447@kroah.com> <422CDA58.5000506@us.ltcfwd.linux.ibm.com> <20050308064211.GE17022@kroah.com> <422DF217.8070401@us.ltcfwd.linux.ibm.com> <20050309060450.GA17560@kroah.com> <422F1B2C.6070405@us.ltcfwd.linux.ibm.com> <20050309163113.GB25079@kroah.com>
In-Reply-To: <20050309163113.GB25079@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Mar 09, 2005 at 10:50:04AM -0500, Wen Xiong wrote:
>  
>
>>+/* Ioctls needed for dpa operation */
>>+#define DIGI_GETDD	('d'<<8) | 248		/* get driver info      */
>>+#define DIGI_GETBD	('d'<<8) | 249		/* get board info       */
>>+#define DIGI_GET_NI_INFO ('d'<<8) | 250		/* nonintelligent state snfo */
>>    
>>
>
>Hm, new ioctls still?...
>
>And the structures you are attempting to access through these ioctls are
>incorrect, so if you are still insisting you need them, at least make
>the code work properly :(
>
>thanks,
>
>greg k-h
>
>  
>
Hi Scott,

The above three ioctls are for dpa/managment. If I removed these ioctls, 
I have to remove jsm_mgmt.c(patch5.jasmine).
Do you mind I remove jsm_mgmt.c code now? From my side, I  don't think I 
need them now.

Maybe we can have a solution in the kernel as Russell and Greg said later.

Thanks,
wendy


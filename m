Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVAaSlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVAaSlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVAaSlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:41:37 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36851 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261303AbVAaSle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:41:34 -0500
Message-ID: <41FE7BD8.9060103@mvista.com>
Date: Mon, 31 Jan 2005 11:41:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: phil@netroedge.com, sensors@stimpy.netroedge.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
References: <41F6F1D5.90601@mvista.com> <20050131182542.GB21438@kroah.com>
In-Reply-To: <20050131182542.GB21438@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Jan 25, 2005 at 06:26:45PM -0700, Mark A. Greer wrote:
>  
>
>>+static inline void
>>+mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
>>    
>>
>
>This is a much too big of a function to be "inline".  Please change it.
>Same for your other inline functions, that's not really needed, right?
>
>  
>
>>+{
>>+	pr_debug("mv64xxx_i2c_fsm: ENTER--state: %d, status: 0x%x\n",
>>+		drv_data->state, status);
>>    
>>
>
>Please use the dev_* calls instead.  It gives you an accurate
>description of the specific device that emits the messages.  Also use it
>for all of the printk() calls in the driver too.
>
>thanks,
>
>greg k-h
>

Certainly.  I already posted this [incremental] patch based on your 
previous comments, 
http://www.ussg.iu.edu/hypermail/linux/kernel/0501.3/0941.html.  Is that 
better?

Mark


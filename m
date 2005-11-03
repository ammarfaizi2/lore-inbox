Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbVKCW5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVKCW5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVKCW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:57:33 -0500
Received: from kirby.webscope.com ([204.141.84.57]:10892 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932658AbVKCW5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:57:32 -0500
Message-ID: <436A959D.8090403@linuxtv.org>
Date: Thu, 03 Nov 2005 17:56:29 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: [PATCH 30/37] dvb: add nxt200x frontend module
References: <43672436.6000006@m1k.net> <20051103141125.1463c1bd.akpm@osdl.org>
In-Reply-To: <20051103141125.1463c1bd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>
>>+
>>+static int nxt200x_writetuner (struct nxt200x_state* state, u8* data)
>>+{
>>+	u8 buf, count = 0;
>>+
>>+	dprintk("%s\n", __FUNCTION__);
>>+
>>+	dprintk("Tuner Bytes: %02X %02X %02X %02X\n", data[0], data[1], data[2], data[3]);
>>+
>>+	/* if pll is a Philips TUV1236D then write directly to tuner */
>>+	if (strcmp(state->config->pll_desc->name, "Philips TUV1236D") == 0) {
>>    
>>
>Does DVB have a better way of identifying a device type than strcmp?
>  
>
I said the same thing when I first saw this, but I wanted to send the 
patches separately, because Kirk wrote the driver, and I corrected the 
above issue in a separate patch:

dvb-determine-tuner-write-method-based-on-nxt-chip.patch

Feel free to fold them if you like... I was only trying to indicate separate authorship.

As for the other comments for the rest of the patch series, some of the fixes are trivial.  Should I expect that you will correct these?  or do you need me to send you more patches?

For now, I think the corrections should wait for Johannes' return, 
unless you want to take care of them.  I think he comes back JUST after 
the end of the merge window... not quite sure.

I have 3 or 4 more patches coming.... I plan to send before the end of 
tonight.

Regards,

Michael Krufky



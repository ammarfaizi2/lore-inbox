Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVF0DjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVF0DjS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVF0DjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:39:17 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:35231 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261740AbVF0DjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:39:08 -0400
Message-ID: <42BF74DA.6040202@dev.rtsoft.ru>
Date: Mon, 27 Jun 2005 07:39:06 +0400
From: Vitaly Wool <vwool@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru> <200506270049.10970.adobriyan@gmail.com>
In-Reply-To: <200506270049.10970.adobriyan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>> +static void        *phys_spi_data_reg = 0;
>>   
>
>
> NULL for pointers.
>
>  
>
>> +void spipnx_select_chip (void)
>> +{
>> +    unsigned reg = gpio_read_reg (PADMUX1_MODE0);
>> +    gpio_write_reg ((reg & ~GPIO_PIN_SPI_CE), PADMUX1_MODE0); }
>>   
>
>
> Closing brackets on the separate line, _please_.
>
>  
>
>> +static void spipnx_spi_init (void *algo_data) {
>>   
>
>
> As well as opening ones.
>
>  
>
>> --- /dev/null
>> +++ linux-2.6.10/drivers/spi/spi-pnx010x_atmel.c
>>   
>
>
>  
>
Hm, as far as I understand, this patch is not intended to become a part 
of kernel; neither it is posted to go through a formal review. It's just 
an example usage of the SPI core, isn't it?

What I would like to see, however, is dealing with the scatter-gather 
lists. I guess this should be in algorithm, isn't it?


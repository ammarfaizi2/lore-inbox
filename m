Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVADQ2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVADQ2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVADQZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:25:43 -0500
Received: from [195.23.16.24] ([195.23.16.24]:35746 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261739AbVADQVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:21:49 -0500
Message-ID: <41DAC298.6070509@grupopie.com>
Date: Tue, 04 Jan 2005 16:21:44 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
Cc: Lethalman <lethalman@fyrebird.net>, linux-kernel@vger.kernel.org
Subject: Re: Let me know EIP address
References: <41DAB3AA.4010207@fyrebird.net> <Pine.LNX.4.61.0501041103300.4931@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501041103300.4931@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Tue, 4 Jan 2005, Lethalman wrote:
> 
>> I'm trying to get the EIP value from a simple program in C but i don't 
>> how to do it. I need it to know the current address position on the 
>> code segment.
>>
>> main() {
>>  long *eip;
>>  asm("mov %%eip,%0" : "=g"(eip));
>>  printf("%p\n", eip);
>> }
>>
>> Unfortunately EIP is not that kind of register :P
>> Does anyone know how to get EIP?
>>
> 
> You get the offset of a label, i.e., "foo:\t movl $foo,%0\n" in the asm 
> code.

Or use a gcc extension, so that you don't have to write assembly code:

int main(int argc, char *argv[])
{
   address:
     printf("this is my address %p\n", &&address);
   return 0;
}

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu


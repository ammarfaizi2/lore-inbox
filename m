Return-Path: <linux-kernel-owner+w=401wt.eu-S932978AbXABIZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbXABIZg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 03:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbXABIZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 03:25:36 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:43539 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932978AbXABIZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 03:25:35 -0500
Message-ID: <459A1760.7010805@student.ltu.se>
Date: Tue, 02 Jan 2007 09:27:12 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/8] UML - audio driver formatting
References: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>	<4599BAE1.9050804@student.ltu.se> <20070101182322.b365543a.rdunlap@xenotime.net>
In-Reply-To: <20070101182322.b365543a.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Tue, 02 Jan 2007 02:52:33 +0100 Richard Knutsson wrote:
>
>   
>> Jeff Dike wrote:
>>     
>>> Whitespace and style fixes.
>>>
>>> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>>> --
>>>  arch/um/drivers/hostaudio_kern.c |  160 +++++++++++++++++----------------------
>>>  1 file changed, 73 insertions(+), 87 deletions(-)
>>>
>>> Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
>>> ===================================================================
>>> --- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:41.000000000 -0500
>>> +++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:42.000000000 -0500
>>> @@ -15,11 +15,11 @@
>>>  #include "os.h"
>>>  
>>>  struct hostaudio_state {
>>> -  int fd;
>>> +	int fd;
>>>  };
>>>  
>>>  struct hostmixer_state {
>>> -  int fd;
>>> +	int fd;
>>>  };
>>>  
>>>  #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
>>> @@ -72,12 +72,12 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
>>>  static ssize_t hostaudio_read(struct file *file, char __user *buffer,
>>>  			      size_t count, loff_t *ppos)
>>>  {
>>> -        struct hostaudio_state *state = file->private_data;
>>> +	struct hostaudio_state *state = file->private_data;
>>>  	void *kbuf;
>>>  	int err;
>>>  
>>>  #ifdef DEBUG
>>> -        printk("hostaudio: read called, count = %d\n", count);
>>> +	printk("hostaudio: read called, count = %d\n", count);
>>>  #endif
>>>  
>>>  	kbuf = kmalloc(count, GFP_KERNEL);
>>> @@ -91,7 +91,7 @@ static ssize_t hostaudio_read(struct fil
>>>  	if(copy_to_user(buffer, kbuf, err))
>>>  		err = -EFAULT;
>>>  
>>> - out:
>>> +out:
>>>   
>>>       
>> Isn't labels _suppose_ to be spaced? (due to "grep", if I'm not mistaken)...
>>     
>
> There was some noise about that (due to 'patch' IIRC).
> I tested it and could not cause a problem with labels beginning
> in column 0.  Can you?
>   
Can't say I have (even thou I have not tried so much). You seem to have 
it covered, sorry for adding to the noise.
>   
>>>  	kfree(kbuf);
>>>  	return(err);
>>>  }
>>>       
>
>
>   
Richard Knutson


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWFAUDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWFAUDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWFAUDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:03:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:48443 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030259AbWFAUDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:03:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pNCqbdmA+p9euH/KVw91fmufeUEzU6/1+WIbWu2qF0vVI5BklOBu48iDhNe8RAXpSDPFZjTbKifM1n9Op7OOVDS47KcnjgsEBBkbRrKNZhPw8a8ZBdk2RnzmxzOdCqBGXVfa3OVDOSg+Jxtt0Px3MTEGraJ9fW92ujm5i1L6I9c=
Message-ID: <447F47FD.2050705@gmail.com>
Date: Thu, 01 Jun 2006 23:03:09 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: input: fix comments and blank lines in new ff code
References: <20060530105705.157014000@gmail.com>	<20060530110131.136225000@gmail.com>	<20060530222122.069da389.rdunlap@xenotime.net>	<447F3AE4.6010206@gmail.com> <20060601125256.de2897f4.rdunlap@xenotime.net>
In-Reply-To: <20060601125256.de2897f4.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Thu, 01 Jun 2006 22:07:16 +0300 Anssi Hannula wrote:
> 
> 
>>Fix comments so that they conform to kernel-doc and add/remove some
>>blank lines.
>>
>>Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> 
> 
> (attachments make review/comments more trying, so this is an
> abbreviated reply)

Sorry, I'll try to use some other client when I send the fixed patch.

>  /**
> - * Lock the mutex and check the device has not been deleted
> + * input_ff_safe_lock - lock the mutex and check for the ff_device struct
> + *
> + * Returns 0 if device still present, 1 otherwise.
>   */
>  static inline int input_ff_safe_lock(struct input_dev *dev)
>  {
> 
> Functions that are commented with kernel-doc need all of the parameters
> documented also, like:
> 
>  * @dev: the input_dev (or better description)
> 
> There were a few places where you had these and deleted them.  :(
> ~~~~~~~~~~~~~~
> 
> (repeat for several functions...)
> 

Ah, so if the comment is kernel-doc all parameters have to be always
documented...

I guess I can just remove the double ** for static functions, as I'm not
sure it is necessary to document all the obvious parameters of those.

Or what do you think?

-- 
Anssi Hannula


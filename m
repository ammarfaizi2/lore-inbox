Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbTHVVrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTHVVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:47:52 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:55567 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263400AbTHVVrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:47:51 -0400
Message-ID: <3F469384.5090909@techsource.com>
Date: Fri, 22 Aug 2003 18:04:52 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: torvalds@osdl.org, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
References: <20030822210800.GA4403@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:

>  static int __init resume_setup(char *str)
>  {
> -	strncpy( resume_file, str, 255 );
> +	if (strlen(str))
> +		strncpy(resume_file, str, 255);
>  	return 1;
>  }


Silly me, but if you want to check to be sure a string has a length 
greater than zero, wouldn't it be faster to just check to be sure that 
the first byte is not zero?

Think about how much work it does if the string is 100 characters long 
when all you want to do is determine that it's non-zero.



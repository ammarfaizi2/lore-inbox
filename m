Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVCCL2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVCCL2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVCCLY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:24:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44191 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261632AbVCCLQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:16:01 -0500
Message-ID: <4226F1DE.6000900@pobox.com>
Date: Thu, 03 Mar 2005 06:15:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Documentation update
References: <20050303102852.GG8617@admingilde.org>
In-Reply-To: <20050303102852.GG8617@admingilde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> Hoi :)
> 
> I'm still working on fixing and updating the Linux DocBook
> Documentation.  My tree currently consists of several fixes
> to the Documentation generation, some additional kernel-doc
> entries and a move from SGML to valid XML.
> 
> Please have a look at it and consider merging.


Overall, looks pretty good.

Comments:

1) As the author of tulip-user and via-audio docbooks, I can say that 
they are out of date and should be deleted.


2) Very happy to see conversion to XML.


3) In general, I'm happy that someone is giving the docbook docs some love.


4) Occasionally code movement (not just comment updates) are required, 
such as:

> @@ -1248,6 +1249,9 @@
>         return retval;
>  }
>  
> +
> +extern const char *global_mode_option;
> +
>  /**
>   *     video_setup - process command line options
>   *     @options: string of options
> @@ -1261,9 +1265,6 @@
>   *     Returns zero.
>   *
>   */
> -
> -extern const char *global_mode_option;
> -
>  int __init video_setup(char *options)
>  {
>         int i, global = 0;

Although I do not NAK this change, I am curious if kernel-doc can be 
fixed so that this sort of change is not necessary.


5) Although it is a pain to do this in BitKeeper, now that you've 
checked everything in, it might be better to send the code changes via 
the individual maintainers.


6) I would feel more comfortable if this spent some time in Andrew 
Morton's -mm, before going upstream.

Regards,

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUCQSRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUCQSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:17:44 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:54003 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261900AbUCQSRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:17:35 -0500
Message-ID: <4058963A.6060805@nortelnetworks.com>
Date: Wed, 17 Mar 2004 13:17:30 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: VINOD GOPAL <vinod_gopal74@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arithmetic functions for linux driver
References: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VINOD GOPAL wrote:
> Hi,
>  I am new to linux world and this mailing list.
> 
>  I need to use the arithmetic functions like sin, cos,
> exp, log, etc in linux device driver.
> 
>  On search read , not to use libm from kernel driver
> as it will harm the fpu registers.
>   
>   Do you have any insight how to support these
> functions in linux driver or any code that is
> available which I can make use of?

Best would be to try and have userspace do it for you.

If you really need to do it in the kernel on the fly, you'll need to either

1) save and restore the floating point context yourself
2) use fixed point calculations

As an optimization for 2, you could pre-calculate some lookup tables and 
interpolate.


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


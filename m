Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUCQXVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUCQXVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:21:44 -0500
Received: from alt.aurema.com ([203.217.18.57]:45236 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262149AbUCQXVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:21:13 -0500
Message-ID: <4058DD61.3070308@aurema.com>
Date: Thu, 18 Mar 2004 10:21:05 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: VINOD GOPAL <vinod_gopal74@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: arithmetic functions for linux driver
References: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
In-Reply-To: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
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

I'd recommend using fixed denominator rational numbers to represent real 
numbers and polynomial approximations for the transcendental functions. 
  We do this in our EBS scheduler patches and it seems to be successful. 
  The main downside to this approach is the limited range (and 
precision) of values that can be represented so you need to have a clear 
idea of the likely values at various stages of your calculations.

The "Handbook of Mathematical Functions" by Abramowitz and Stegun, Dover 
Publications, New York ISBN 486-61272-4 (LCN 65-12253) is a good source 
of methods for approximating functions.

If you'd like more detailed assistance don't hesitate to ask.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


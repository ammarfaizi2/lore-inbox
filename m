Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVHRKhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVHRKhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVHRKhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:37:36 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:11281 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932135AbVHRKhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:37:36 -0400
Message-ID: <430464EA.5050007@rainbow-software.org>
Date: Thu, 18 Aug 2005 12:37:30 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: FPU-intensive programs crashing with floating point  exception
 on Cyrix MII
References: <200508171453_MC3-1-A76E-CAE6@compuserve.com>
In-Reply-To: <200508171453_MC3-1-A76E-CAE6@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Wed, 17 Aug 2005 at 18:13:55 +0200, Ondrej Zary wrote:
> 
> 
>>When I run a program that uses FPU, it sometimes crashes with "flaoting 
>>point exception"
> 
> 
> 
>>+     printk("MATH ERROR %d\n",((~cwd) & swd & 0x3f) | (swd & 0x240));
> 
> 
>   Could you modify this to print the full values of cwd and swd like this?
> 
>         printk("MATH ERROR: cwd = 0x%hx, swd = 0x%hx\n", cwd, swd);
> 
> Then post the result.
MATH ERROR: cwd = 0x37f, swd = 0x5020
MATH ERROR: cwd = 0x37f, swd = 0x20
MATH ERROR: cwd = 0x37f, swd = 0x20
MATH ERROR: cwd = 0x37f, swd = 0x2020
MATH ERROR: cwd = 0x37f, swd = 0x20
MATH ERROR: cwd = 0x37f, swd = 0x1820
MATH ERROR: cwd = 0x37f, swd = 0x1820
MATH ERROR: cwd = 0x37f, swd = 0x2020
MATH ERROR: cwd = 0x37f, swd = 0x20
MATH ERROR: cwd = 0x37f, swd = 0x2800
MATH ERROR: cwd = 0x37f, swd = 0x1820
MATH ERROR: cwd = 0x37f, swd = 0x820
MATH ERROR: cwd = 0x37f, swd = 0x2820
MATH ERROR: cwd = 0x37f, swd = 0x2820
MATH ERROR: cwd = 0x37f, swd = 0x1820
MATH ERROR: cwd = 0x37f, swd = 0x820
MATH ERROR: cwd = 0x37f, swd = 0x1a20

Running prime95 for almost 2 hours:
Torture Test ran 1 hours, 54 minutes - 0 errors, 0 warnings.
and playing some mpeg clips.

-- 
Ondrej Zary

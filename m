Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUDEOig (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDEOig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:38:36 -0400
Received: from cardinal.mail.pas.earthlink.net ([207.217.121.226]:989 "EHLO
	cardinal.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262650AbUDEOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:38:02 -0400
Message-ID: <40716F40.4070609@penguincomputing.com>
Date: Mon, 05 Apr 2004 07:37:52 -0700
From: Philip Pokorny <ppokorny@penguincomputing.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org,
       Michael Hunold <m.hunold@gmx.de>, Greg KH <greg@kroah.com>
Subject: Re: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
 isolation
References: <40686476.7020603@convergence.de>	<406EBA38.1030203@gmx.de>	<20040403163031.122b5df8.khali@linux-fr.org> <1081163597.607.15.camel@newt>
In-Reply-To: <1081163597.607.15.camel@newt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:

>On Sat, 2004-04-03 at 15:30, Jean Delvare wrote:
>
>  
>
>>I'm not sure that the function you propose would be really useful. I
>>guess that most people don't load i2c chip drivers they don't need. The
>>class filter you propose, added to the different I2C addresses, should
>>do the rest.
>>    
>>
>
>What about using two DVB cards of different models to record off one
>multiplex while watching another?
>
>Only an explicit list of which chips should be probed on each I2C bus is
>safe for this sort of system.
>
>  
>
You might be able to use the ignore= and force=  parameters to the i2c 
drivers to accomplish this.  With ignore you can prevent a driver from 
scanning an address (specify -1 as the bus to ignore that address on all 
busses) and with force you can specify which bus/address to find the 
specific chip.

I haven't read the code in detail yet, but if force doesn't already 
override ignore, it probably should.  I can't think of reason why you 
would want ignore to override a force directive.

:v)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUCJU4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbUCJU4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:56:54 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19138 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262814AbUCJUzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:55:05 -0500
Message-ID: <404F7EF8.5020402@acm.org>
Date: Wed, 10 Mar 2004 14:47:52 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>,
       sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de> <20040310190648.GB18892@kroah.com>
In-Reply-To: <20040310190648.GB18892@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Mar 10, 2004 at 07:51:05PM +0100, Adrian Bunk wrote:
>  
>
>>On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
>>    
>>
>>>...
>>>I have included a patch from Todd Davis at Intel that adds this function 
>>>to the I2C driver.  I believe Todd has been working on getting this in 
>>>through the I2C driver writers, although the patch is fairly non-intrusive.
>>>
>>>However, I have no real way to test this patch.
>>>...
>>>      
>>>
>>I can only confirm that it fixes the compilation...
>>
>>
>>The patch to i2c-core.c is strange:
>>    
>>
>
>And dumb, and incorrect :(
>
>  
>
Wrong as in: "This code will not work" or wrong as in: "don't export the 
variable and the function", or both?  I certainly agree that exporting 
both is wrong, there should really be two inline functions with only the 
variable exported, or only functions exported and the variable hidden.  
That's an easy change.

However, if the code does not work, that is a bigger deal.  I'm fairly 
sure it works in some cases, but not sure about all.

The patch I posted is for 2.6, BTW.

-Corey


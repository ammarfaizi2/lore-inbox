Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVA0AMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVA0AMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVA0AHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:07:17 -0500
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:57529 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262463AbVAZVdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:33:16 -0500
Message-ID: <41F80CA2.2080603@246tNt.com>
Date: Wed, 26 Jan 2005 22:33:22 +0100
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>	<1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
In-Reply-To: <1106529935.5587.9.camel@gaston>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:
>
>  
>
>>I know about this problem, I'm working on a proper fix. Thanks for your
>>report.
>>    
>>
>
>Can you send me the PVR value for both of these CPUs
>(cat /proc/cpuinfo) ? I can't find right now why they would lock up
>unless the default idle loop is _not_ run properly, that is for some
>reason, NAP or DOZE mode end up not beeing enabled. Can you send me
>your .config as well ?
>  
>
Note that when CONFIG_BDI_SWITCH is set, they both end up disabled
because nap & doze seems to perturb the BDI on some cores.

So there is a problem in that case ....

>Finally, try that patch and tell me if it makes a difference. 
>
Yup
 - Without it hangs (not really, it's still half running but serial 
output is stuck
due to no interrupts)
 - With it it works


    Sylvain


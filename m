Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVILLXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVILLXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVILLXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:23:40 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:7334 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S1750744AbVILLXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:23:39 -0400
Message-ID: <432564F2.3080605@metaparadigm.com>
Date: Mon, 12 Sep 2005 19:22:26 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Brad Tilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
Subject: Re: Universal method to start a script at boot
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <1126462467.43247403c2e1c@wmtest.cc.vt.edu> <43250150.20308@metaparadigm.com> <200509121249.40467.vda@ilport.com.ua>
In-Reply-To: <200509121249.40467.vda@ilport.com.ua>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Monday 12 September 2005 07:17, Michael Clark wrote:
>  
>
>>>>Is there a standard way to start a script or program at boot that will work
>>>>on any Linux kernel/distro no matter which init system is being used or how it
>>>>has been configured? Probably not, but I thought someone here could possibly
>>>>answer this.
>>>>        
>>>>
>>You could use the LSB conforming method of writing and installing
>>an init script:
>>
>>http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
>>http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptfunc.html
>>http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initscrcomconv.html
>>http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initsrcinstrm.html
>>    
>>
>
>Awful. This codifies ages-old Unix traditional SysV-like init
>and its derivatives, which should be get rid of instead.
>
>  
>
Actually if you look closer it is a bit smarter than sysvinit and
includes latent functionality that the distros will eventually pick up
on to increase boot speed and allow parallel starting of services (it
codifies boot dependencies with provides and requires - not just boot
order like svsvinit).

http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initscrcomconv.html


For example an extract from /etc/init.d/vmware

# Basic support for the Linux Standard Base Specification 1.3
# Used by insserv and other LSB compliant tools.
### BEGIN INIT INFO
# Provides: VMware
# Required-Start: $network $syslog
# Required-Stop:
# Default-Start: 2 3 5
# Default-Stop: 0 6
# Short-Description: Manages the services needed to run VMware software
# Description: Manages the services needed to run VMware software
### END INIT INFO

And whether you think it is awful or not - it is the closest thing we
have to universal in Linux land (which is what the original poster was
asking) ie. all of the major distros are aiming for LSB conformance.

~mc

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268064AbTBMPp1>; Thu, 13 Feb 2003 10:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268067AbTBMPp1>; Thu, 13 Feb 2003 10:45:27 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37834 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268064AbTBMPpW>; Thu, 13 Feb 2003 10:45:22 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: wingel@nano-systems.com, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20030213115545.GA26814@codemonkey.org.uk>
References: <1045106216.1089.16.camel@vmhack> 
	<20030213115545.GA26814@codemonkey.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 07:34:35 -0800
Message-Id: <1045150488.1009.3.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 03:55, Dave Jones wrote:
> On Wed, Feb 12, 2003 at 07:16:55PM -0800, Rusty Lynch wrote:
>  > Basically, with the help of some watchdog infrastructure code, we could make 
>  > each watchdog device register as a platform_device named watchdog, so for 
>  > every watchdog on the system there is a /sys/devices/legacy/watchdogN/ 
>  > directory created for it.  
> 
> Why legacy ? That seems an odd place to be putting these.
> 
> 		Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs

The watchdogN devices show up under the "legacy" directory because
they are platform devices.  From reading the driver-model documentation,
I believe that platform devices are the correct way of categorizing
watchdog devices.

<pasting from Documentation/driver-model/platform.txt>

Platform devices
~~~~~~~~~~~~~~~~
Platform devices are devices that typically appear as autonomous
entities in the system. This includes legacy port-based devices and
host bridges to peripheral buses. 


Platform drivers
~~~~~~~~~~~~~~~~
Drivers for platform devices have typically very simple and
unstructured. Either the device was present at a particular I/O port
and the driver was loaded, or there was not. There was no possibility
of hotplugging or alternative discovery besides probing at a specific
I/O address and expecting a specific response.

</pasting from Documentation/driver-model/platform.txt>



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTH3A3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 20:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTH3A3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 20:29:45 -0400
Received: from astro.as.arizona.edu ([128.196.208.2]:37136 "EHLO
	astro.as.arizona.edu") by vger.kernel.org with ESMTP
	id S262182AbTH3A3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 20:29:43 -0400
Message-ID: <3F4FEFE9.4050704@as.arizona.edu>
Date: Fri, 29 Aug 2003 17:29:29 -0700
From: don fisher <dfisher@as.arizona.edu>
Organization: caao
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to choose between ip 2 identical ethernet cards
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for a bit off topic.

I have a Dell 8200 laptop and a docking station, both with 3c905C 
ethenet chips. I wish to use the 3c905c internal to the docking 
station when the system is docked. Otherwise the 3c905c internal to 
the 8200. In my office I would like to run with both eth0 and eth1, 
but I need to be able to connect the correct interface to the correct 
cable. The same module is loaded for both devices.

The HOWTOs I found all assumed you had old cards with fixed addresses. 
These could be specified as options in modules.conf. From the Net-HOWTO:
         alias eth0 ne
         alias eth1 ne
         alias eth2 ne
         options ne io=0x220,0x240,0x300
But this does not seem to apply to the 3c59x driver. modinfo doesn't 
even list "io" as a valid option.

I did find:
  1) in /proc/ioports, one of the devices is listed with "(#2)" after it.
  2) in /etc/sysconfig/hwconf, one of the devices has
subDeviceId = 00d4, the other 00de.

I have tried changing the order of loading modules, along with a few 
vain attempts in modules.conf. For info, this is a Redhat system. 
Where is the definition as to which device will be associated with 
eth0 made?

Any assistance would be appreciated. I did try to RTFM, I just can't 
find the correct "fine manual";-)
thanks
don

-------------------------------------------------------------------
|    Don Fisher				  dfisher@as.arizona.edu  |
|    Steward Observatory		  			  |
|    933 N. Cherry Ave.    		  VOICE: (520)621-7647	  |
|    University of Arizona		  FAX:   (520)621-9843    |
|    Tucson, AZ  85721                				  |
-------------------------------------------------------------------



-- 
redhat-list mailing list
unsubscribe mailto:redhat-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/redhat-list



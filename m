Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbTCMA11>; Wed, 12 Mar 2003 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261830AbTCMA10>; Wed, 12 Mar 2003 19:27:26 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:15604 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S261825AbTCMA1Z>; Wed, 12 Mar 2003 19:27:25 -0500
Date: Wed, 12 Mar 2003 16:37:55 -0800
From: Chris Wright <chris@wirex.com>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] kobject support for LSM core (v2)
Message-ID: <20030312163755.I466@figure1.int.wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20030310001310.GU3917@pasky.ji.cz> <20030310064738.GD6512@kroah.com> <20030312232027.GQ7397@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030312232027.GQ7397@pasky.ji.cz>; from pasky@ucw.cz on Thu, Mar 13, 2003 at 12:20:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Petr Baudis (pasky@ucw.cz) wrote:
> 
> At the time of security_scaffolding_setup(), sysfs is not mounted yet, thus
> subsystem_register() returns -EFAULT and is unsuccessful.

yup, same problem with the early init patch.

>  A lot of LSMs use various ad hoc methods for communication with the userspace
> and using the sysfs framework could be very convient for them, and there is at

This would be more compelling if you could convert something in the LSM
tree to using it.  Right now, this patch just adds something that is not
clearly needed.  What about converting DTE to use this new subsystem?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

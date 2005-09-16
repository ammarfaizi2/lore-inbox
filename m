Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbVIPIjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbVIPIjI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 04:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161135AbVIPIjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 04:39:08 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24805 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161134AbVIPIjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 04:39:07 -0400
Subject: Re: [patch 6/7] s390: ipl device.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050916071444.GA11851@osiris.boeblingen.de.ibm.com>
References: <20050914155509.GE11478@skybase.boeblingen.de.ibm.com>
	 <20050915171718.GA9833@kroah.com>
	 <20050916071444.GA11851@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 10:39:09 +0200
Message-Id: <1126859949.4923.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 09:14 +0200, Heiko Carstens wrote:
> > > Export the ipl device settings to userspace via the sysfs:
> > >  * /sys/kernel/ipl_device
> > What?  Why that location?  Why not in the proper location for your
> > device, on your bus?
> 
> This interface tells from where the kernel was booted from. I don't
> think a device should have an attribute where the meaning would be
> "the current running kernel came via this device into memory".
> IMHO this should be an attribute of the kernel and therefore I
> thought /sys/kernel would be a good idea.

If the additional ipl information is bound to the ipl device then we'd
have to search for the device if we'd want to get the ipl information.
And if we ever want to make /sys/kernel/ipl_device writable to be able
to change the ipl_device for a reboot then what? Have the ipl related
sysfs files for ALL devices you can ipl from to be able to move to
another device? I think we need a central place for this information.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbTDCBVo>; Wed, 2 Apr 2003 20:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263206AbTDCBVo>; Wed, 2 Apr 2003 20:21:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:51902 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263203AbTDCBVn>; Wed, 2 Apr 2003 20:21:43 -0500
Date: Wed, 2 Apr 2003 17:23:07 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: i2c_probe() vs i2c_detect()
Message-ID: <20030403012307.GA6037@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can anyone tell me why both i2c_probe() and i2c_detect() are in the
kernel at the same time?  They both almost do the same thing, with the
exception being i2c_detect() can handle i2c devices on the isa bus.

It kind of looks like the older i2c code and drivers used the
i2c_probe() call, while the lm_sensors code used i2c_detect().

If there are no objections, I'll merge the two of them, cutting about 2k
out of the kernel :)

thanks,

greg k-h

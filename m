Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263951AbUKZTzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263951AbUKZTzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263956AbUKZTyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:54:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262471AbUKZTbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:31:12 -0500
Date: Thu, 25 Nov 2004 10:31:37 -0800
From: Greg KH <greg@kroah.com>
To: jamagallon@able.es, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm3
Message-ID: <20041125183137.GA30975@kroah.com>
References: <20041125022405.5fc37efa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125022405.5fc37efa.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2004.11.22, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm3/
> > 
> 
> Problem with /sys/bus/i2c/devices empty.
> 
> I am running a 2.10-rc2-mm3 kernel with a couple pathes (unrelated to
> i2c). It shows me an empty directory in /sys/bus/i2c/devices, even
> if I have all suitable modules loaded:

Are you sure these are the proper modules for this system?

> Module                  Size  Used by
> w83627hf               24224  0 
> i2c_dev                 8192  0 
> i2c_sensor              3328  1 w83627hf
> i2c_isa                 2304  0 
> i2c_i801                7692  0 
> i2c_core               18560  5 w83627hf,i2c_dev,i2c_sensor,i2c_isa,i2c_i801
> 
> On boxes running 2.6.9, the devices are present with the same module list
> (different adapters)

Ah, but what about 2.6.9 on this same machine?  Are you sure that the
i2c_i801 driver is the proper one for this box?  How about the w83627hf
driver?  Are you sure that chip is on it?

Have you tried running sensors-detect to determine what drivers are
needed?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVAIAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVAIAOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVAIAOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 19:14:53 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:60955 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262148AbVAIAOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 19:14:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OS4MUUIQHQ6OrF2Ic5YnMqbFTXVpcHiOgVy3qeMKnQPacEv7ll9M4ZqEvPHAshVe4XBPuoqTMIBN0Mwg89KM3MxX2DT2MDTcbIc/mm3igYQ+BWnYWPLTY8rAR/1s/VQhanAeVkMsgxN72WqBN8oOxUCOdithumg/eZt4IiaIfPM=
Message-ID: <9e473391050108161426b36e4d@mail.gmail.com>
Date: Sat, 8 Jan 2005 19:14:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Export symbol from I2C eeprom driver
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050108222719.GA3226@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010721347fbeb907@mail.gmail.com>
	 <20050108055315.GC8571@kroah.com>
	 <9e473391050107220875baa32b@mail.gmail.com>
	 <20050108222719.GA3226@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005 14:27:19 -0800, Greg KH <greg@kroah.com> wrote:
> And why do you need the eeprom driver for the radeon driver to work
> properly?

In the new radeon driver at hotplug time a user space app reads the
DDC from the monitor and sets the list of valid modes into the driver.
The radeon driver includes an I2C driver. The eeprom driver finds the
radeon DDC ROMs and makes them visible to the userspace driver through
sysfs. I could add code to the radeon driver to export the DDC ROMs to
sysfs but the eeprom driver works fine.

I don't want to load the driver from the script because the radeon
driver is creating a sysfs link into the eeprom directory from the
radeon one.

-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWDMJco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWDMJco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWDMJco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:32:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23567 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964830AbWDMJco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:32:44 -0400
Date: Thu, 13 Apr 2006 10:31:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again if probe was unsuccessful
Message-ID: <20060413093146.GB21632@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Oeser <ioe-lkml@rameria.de>,
	Rene Herman <rene.herman@keyaccess.nl>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Greg KH <gregkh@suse.de>
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604131126.35841.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:26:34AM +0200, Ingo Oeser wrote:
> Hi Rene,
> Wouldn't it be more useful to do these checks in 
> platform_register_simple() and return the proper error value there?

Firstly, platform_device_register_simple() is going away.

Secondly, it's inappropriate to force this weirdo ALSA specific behaviour
on the rest of the platform device users.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVAMXnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVAMXnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVAMXkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:40:41 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:36045 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261820AbVAMXbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:31:22 -0500
Date: Thu, 13 Jan 2005 15:29:04 -0800
From: Greg KH <greg@kroah.com>
To: Jonas Munsin <jmunsin@iki.fi>, Jean Delvare <khali@linux-fr.org>,
       pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com, djg@pdp8.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-ID: <20050113232904.GC2458@kroah.com>
References: <200501102341.44949.pioppo@ferrara.linux.it> <YN0o4rkI.1105435582.0805630.khali@localhost> <20050112222735.GA13572@nemo.sby.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112222735.GA13572@nemo.sby.abo.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 12:27:35AM +0200, Jonas Munsin wrote:
> > 2* I would then add a check to the it87 driver, which completely disables
> > the fan speed control interface if the initial configuration looks weird
> > (all fans supposedly stopped and polarity set to "active low"). This
> > should protect users of the driver who have a faulty BIOS.
> > 
> > When a bogus configuration is detected, we would of course complain in
> > the logs and invite the user to complain to his/her motherboard maker
> > too.
> 
> Here is it87.c_2.6.10-jm4-detect_broken_bios_20050112.diff implementing
> this. It goes on top of the previous patch.
> 
> - detects broken bioses, disables the pwm for them and prints a message
> - fixes an unrelated minor bug in set_fan_div()
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Jonas Munsin <jmunsin@iki.fi>

Applied, thanks.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264152AbTFPSbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 14:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFPS3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 14:29:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29337 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264127AbTFPS3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 14:29:11 -0400
Date: Mon, 16 Jun 2003 11:42:13 -0700
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [RFC PATCH] Add lm78 sensor chip support (2.5.70)
Message-ID: <20030616184213.GE25585@kroah.com>
References: <20030608223334.GC30962@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608223334.GC30962@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 06:33:34PM -0400, Mark M. Hoffman wrote:
> This patch vs. 2.5.70 adds support for LM78, LM78-J, and LM79 sensors
> chips based on lm_sensors project CVS.  This works on one of my boards.
> 
> I want to draw attention to something I did with this driver by
> comparing it to it87.c in 2.5.70:
> 
> > #define IT87_INIT_TEMP_HIGH_1 600
> > #define IT87_INIT_TEMP_LOW_1  200
> 
> The hardware uses degrees C, and sysfs uses degrees C * 1000.  But
> these #defines are apparently in units of degrees C * 10.  This
> arbitrary intermediate representation bugs me.  And given the new 2.5
> sysfs standard, it's unnecessary.
> 
> In this patch for lm78, I rewrote the conversion routines in terms
> of the sysfs units - getting rid of the intermediate nonsense.  If
> there are no objections, I'm going to start passing patches to do
> this to the other sensor chip drivers in 2.5 as well.  It would be
> nice to get some help with this too... especially since I don't
> have all that hardware at hand to test the results.

Applied, thanks.

greg k-h

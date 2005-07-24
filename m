Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVGXR1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVGXR1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 13:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGXR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 13:27:09 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:38543 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261410AbVGXR1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 13:27:07 -0400
Date: Sun, 24 Jul 2005 19:29:47 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Keith Owens <kaos@ocs.com.au>, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Message-ID: <20050724172947.GF20437@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Sam Ravnborg <sam@ravnborg.org>, Keith Owens <kaos@ocs.com.au>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@stusta.de>
References: <20050722194600.GA8757@mars.ravnborg.org> <3945.1122185413@ocs3.ocs.com.au> <20050724085845.GA8018@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724085845.GA8018@mars.ravnborg.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.235.233
Subject: Re: Why build empty object files in drivers/media?
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 08:58:45AM +0000, Sam Ravnborg wrote:
> On Sun, Jul 24, 2005 at 04:10:13PM +1000, Keith Owens wrote:
> > >
> > >diff --git a/drivers/media/Makefile b/drivers/media/Makefile
> > >--- a/drivers/media/Makefile
> > >+++ b/drivers/media/Makefile
> > >@@ -2,4 +2,7 @@
> > > # Makefile for the kernel multimedia device drivers.
> > > #
> > > 
> > >-obj-y        := video/ radio/ dvb/ common/
> > >+obj-y                   := common/
> > >+obj-$(CONFIG_VIDEO_DEV) := video/
> > >+obj-$(CONFIG_VIDEO_DEV) := radio/
> > >+obj-$(CONFIG_DVB)       := dvb/
> > 
> > That should be +=, not :=
> > 
> > +obj-$(CONFIG_VIDEO_DEV) += video/
> > +obj-$(CONFIG_VIDEO_DEV) += radio/
> > +obj-$(CONFIG_DVB)       += dvb/
> 
> Correct - thanks!

OK, I'll pick this up and put it in CVS.

Thanks,
Johannes

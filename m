Return-Path: <linux-kernel-owner+w=401wt.eu-S1422699AbXAHSL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbXAHSL2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbXAHSL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:11:27 -0500
Received: from mail.impinj.com ([206.169.229.170]:26693 "EHLO earth.impinj.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422699AbXAHSL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:11:27 -0500
X-Greylist: delayed 1825 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 13:11:27 EST
Subject: Re: trouble loading self compiled vanilla kernel
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Jonas Svensson <jonass@lysator.liu.se>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.51L2.0701081644110.27141@nema.lysator.liu.se>
References: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>
	 <45A228CC.5020004@imap.cc>
	 <Pine.GSO.4.51L2.0701081301520.27141@nema.lysator.liu.se>
	 <45A2611A.7040900@imap.cc>
	 <Pine.GSO.4.51L2.0701081644110.27141@nema.lysator.liu.se>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 09:40:54 -0800
Message-Id: <1168278054.3330.4.camel@impinj-lt-0046>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 16:52 +0100, Jonas Svensson wrote:
> On Mon, 8 Jan 2007, Tilman Schmidt wrote:
> 
> > Jonas Svensson schrieb:
> > > I beleive make install does that in CentOS. There were a new initrd
> > > installed and it was not identical to the one supplied by CentOS.
> >
> > That's surprising. On SuSE I always have to build it separately
> > with mkinitrd, and the kernel makefiles are the same, after all.
> > Anyway, your symptoms definitely look like a bad initrd, so you
> > may want to have a closer look in that area. Perhaps build a
> > kernel you can boot without initrd for testing, ie. with the
> > drivers for the root disk and filesystem built in.
> 
> I will try it again, maybe I missed something. I will also try to read
> more on initrd and see if I am wrong to assume that make install does it
> for me.

In my experience on openSUSE, the following sequence of commands
installs both the kernel and the initrd:
	make *config*
	make
	make modules_install
	make install
However, if the order of the last two make invocations is switched, then
the initrd does not get generated (correctly or at all). Although
unlikely to be the problem, it's a simple thing to eliminate from the
list of possible borkages.

-- Vadim Lobanov



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVIBK6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVIBK6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 06:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVIBK6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 06:58:36 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:54959 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1030419AbVIBK6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 06:58:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.13-mm1: PCMCIA problem
Date: Fri, 2 Sep 2005 12:58:51 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050901035542.1c621af6.akpm@osdl.org> <200509021037.16536.rjw@sisk.pl> <20050902104319.GB9647@elf.ucw.cz>
In-Reply-To: <20050902104319.GB9647@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509021258.51921.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 2 of September 2005 12:43, Pavel Machek wrote:
> Hi!
> 
> > > > > On Thursday, 1 of September 2005 12:55, Andrew Morton wrote:
> > > > > > 
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > > > > 
> > > > > I cannot start PCMCIA on x86-64 SuSE 9.3 on Asus L5D.  Apparently, the following
> > > > > command:
> > > > > 
> > > > > sh -c modprobe --ignore-install firmware_class; echo 30 > /sys/class/firmware/timeout
> > > > > 
> > > > > loops forever with almost 100% of the time spent in the kernel.
> > > > > 
> > > > > AFAICS, 2.6.13-rc6-mm2 is also affected, but the mainline kernels are not.
> > > > 
> > > > OK.  There are no notable firmware changes in there.  While it's stuck
> > > > could you generate a kernel profile?    I do:
> > > > 
> > > > readprofile -r
> > > > sleep 5
> > > > readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40
> > 
> > ]--snip--[
> > 
> > One more piece of information.  This is the one that loops:
> > 
> > echo 30 > /sys/class/firmware/timeout
> 
> Try echo -n ...

Well that helps but it means the SuSE's scripts have to be changed to work with
2.6.13-mm1.  Specifically "/etc/modprobe.d/firmware".  Is that intentional or not?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

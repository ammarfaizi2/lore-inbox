Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbVIBKro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbVIBKro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 06:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVIBKro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 06:47:44 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51435 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030396AbVIBKrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 06:47:43 -0400
Date: Fri, 2 Sep 2005 12:43:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1: PCMCIA problem
Message-ID: <20050902104319.GB9647@elf.ucw.cz>
References: <20050901035542.1c621af6.akpm@osdl.org> <20050901142813.47b349ed.akpm@osdl.org> <200509021030.06874.rjw@sisk.pl> <200509021037.16536.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509021037.16536.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > On Thursday, 1 of September 2005 12:55, Andrew Morton wrote:
> > > > > 
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> > > > 
> > > > I cannot start PCMCIA on x86-64 SuSE 9.3 on Asus L5D.  Apparently, the following
> > > > command:
> > > > 
> > > > sh -c modprobe --ignore-install firmware_class; echo 30 > /sys/class/firmware/timeout
> > > > 
> > > > loops forever with almost 100% of the time spent in the kernel.
> > > > 
> > > > AFAICS, 2.6.13-rc6-mm2 is also affected, but the mainline kernels are not.
> > > 
> > > OK.  There are no notable firmware changes in there.  While it's stuck
> > > could you generate a kernel profile?    I do:
> > > 
> > > readprofile -r
> > > sleep 5
> > > readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40
> 
> ]--snip--[
> 
> One more piece of information.  This is the one that loops:
> 
> echo 30 > /sys/class/firmware/timeout

Try echo -n ...

-- 
if you have sharp zaurus hardware you don't need... you know my address

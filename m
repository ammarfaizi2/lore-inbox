Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbTICAPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 20:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTICAPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 20:15:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:16547 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261284AbTICAPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 20:15:38 -0400
Date: Tue, 2 Sep 2003 17:04:48 -0700
From: Greg KH <greg@kroah.com>
To: John Stoffel <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4-mm4 - USD disconnect oops
Message-ID: <20030903000448.GA21173@kroah.com>
References: <16210.44543.579049.520185@gargle.gargle.HOWL> <20030901065928.GB22647@kroah.com> <16213.12008.527588.874265@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16213.12008.527588.874265@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:59:36PM -0400, John Stoffel wrote:
> >>>>> "Greg" == Greg KH <greg@kroah.com> writes:
> 
> >> Here's the backtrace, my .config is at the end.  It's a PIII Xeon 2 x
> >> 550mhz, Dell Precision 610 motherboard/system, 768mb of RAM.  The only
> >> USB devices are the controllers and the CompactFlash reader, which
> >> works great under 2.4.  
> 
> Greg> Does this happen on 2.6.0-test4?  (no -mm).
> 
> Well, I can now use the usb-storage device under 2.6.0-test4 without
> any problems, but I just did a quick test.  So there's something in
> -mm4 which is messing me and usb in general up.  I've made the
> following changes though, so I should go back and check:
> 
> - upgrade to module-init-tools-0.9.13
> - upgrade to hotplug-2003_08_05-1
> 	     hotplug-base-2003_08_05-1
> 
> I'll see if I can figure out what changed in the -mm4 patch to cause
> this problem.  Could it be the kobject patch Akpm posted?  It looks
> like the oops I've gotten.

Try adding that patch and see if it helps.  It sure can't hurt as it
fixes a real bug in the -mm tree :)

Thanks for testing 2.6.0-test4.

greg k-h

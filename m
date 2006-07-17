Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWGQPtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWGQPtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWGQPtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:49:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:21678 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750870AbWGQPtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:49:15 -0400
Date: Mon, 17 Jul 2006 10:50:49 -0500
From: Brandon Philips <brandon@ifup.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
Message-ID: <20060717154759.GB5661@plankton.ifup.org>
References: <44B5CE77.9010103@cmu.edu> <20060716222846.GA5741@plankton.ifup.org> <20060716225111.GA5661@plankton.ifup.org> <200607171114.26160.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607171114.26160.rjw@sisk.pl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:14 Mon 17 Jul 2006, Rafael J. Wysocki wrote:
> On Monday 17 July 2006 00:51, Brandon Philips wrote:
> > On 17:28 Sun 16 Jul 2006, Brandon Philips wrote:
> > > On 08:31 Thu 13 Jul 2006, Jeremy Fitzhardinge wrote:
> > > > George Nychis wrote:
> > > > >I am not seeing any problems at all, though I am not seeing anything
> > > > >happen :)
> > > > >
> > > > >If I Fn+suspend... nothing happens ... if i Fn+hibernate ... nothing 
> > > > >happens
> > > > >
> > > > >What patches did you use?
> > > > Sounds like your first step is to set up acpi.  What distro are you 
> > > > using?  What happens if you do "echo -n mem > /sys/power/state"?
> > > > 
> > > > The patches you need are to make the ahci disk interface resume 
> > > > properly.  There's a series of 6 patches from Forrest Zhao which he 
> > > > posted to the linux-ide list, and they apply cleanly to 2.6.18-rc1-mm1.
> > > 
> > > I have tried Zhao's patches[1] against 2.6.18-rc1-mm{1,2} and 2.6.18-rc1
> > > and the suspend always stops at:
> > > 
> > > "Switching to UP mode"
> > > 
> > > At that point it hangs; giving a Ctrl+Alt+Del reboots the machine
> > > cleanly.
> > > 
> > > I want to see AHCI suspend working.  So, I am happy to try other patches
> > > or debugging steps.
> > 
> > I just tried booting 2.6.18-rc1-mm1 again and got the following
> > stacktrace which suggests a problem with the ondemand governor.   
> > 
> > After switching to the performance govenor I was able to suspend on
> > 2.6.18-rc1 and 2.6.18-rc1-mm1.
> > 
> > 	Brandon
> Could you please create a bugzilla entry for the ondemand governor problem
> and put this trace in there?

Bug URL: http://bugzilla.kernel.org/show_bug.cgi?id=6851

Thanks,

	Brandon


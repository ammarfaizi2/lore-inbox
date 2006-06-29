Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWF2T0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWF2T0E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWF2TZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:25:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:47073 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932288AbWF2TZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:25:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: swsusp problems with 2.6.17-1.2139_FC5
Date: Thu, 29 Jun 2006 21:25:37 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <m2irmj9937.fsf@phoenix.squirrel.nl>
In-Reply-To: <m2irmj9937.fsf@phoenix.squirrel.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606292125.37568.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 29 June 2006 19:15, Johan Vromans wrote:
> swsusp has problems resumeing after upgrading my Acer Travelmate
> 4001WLMi from 2.6.16 to 2.6.17. Note that I'm running a Fedora 5
> kernel, with the ATI proprietary video driver.
> On this 512Mb system, I have typically 60% of memory in use when I go
> into hibernate. This is with X, wm, Emacs, some xterms, wireless.
> 
> With 2.6.16, when I initiate a hibernate with
> 
>   echo shutdown > /sys/power/disk; echo disk > /sys/power/state
> 
> I get switched back to vt1(?), the "stopping tasks" messages, and so
> on, until the system shuts down in ordinary fashion. 
> 
> With 2.6.17, when I initiate the hibernate, I get no apparent reaction
> (although the flashing disk led reveals what's going on) and the
> system shuts down.
> 
> Upon reboot, I get
> 
>   Trying to resume from /dev/hda4
>   Resuming from /dev/hda4.
>   Attempting manual resume
> 
> and then the console does a half-hearted attemtp to restore X and
> freezes. The system is alive, I can login via the network. Restarting
> the X server (from another tty, the console remains stuck) seems to
> 'cure' the problem. However, when exiting X the console stays
> connected to vt7 and needs to be put back to vt1 manually.
> 
> It seems to be a problem with the video switching out/in X. 
> When I change to a vt out of X, then suspend/resume seems to give no
> problem and after resume I can switch back to vt7 into X.
> 
> Any suggestions to cure this problem? Is it a know regression?

It is not known, thanks for the report.

Pavel, is the recent Linus' patch likely to cause this?

Rafael

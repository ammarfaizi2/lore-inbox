Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUEQNWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUEQNWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 09:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUEQNWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 09:22:36 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261234AbUEQNWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 09:22:33 -0400
Date: Sat, 15 May 2004 05:03:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Todd Poynor <tpoynor@mvista.com>
Cc: ncunningham@linuxmail.org, Greg KH <greg@kroah.com>,
       mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Hotplug events for system suspend/resume
Message-ID: <20040515030315.GB460@elf.ucw.cz>
References: <20040511010015.GA21831@dhcp193.mvista.com> <200405121216.02787.ncunningham@linuxmail.org> <40A18F94.4000607@mvista.com> <200405121359.50899.ncunningham@linuxmail.org> <40A27CB8.1010507@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A27CB8.1010507@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi, my main interest is embedded platforms that may or (usually) do not 
> implement ACPI.  Therefore, part of what I've been generally driving at 
> is that there may be value to adding support for these sorts of 
> kernel-to-userspace notifiers in the generic power layer.  As I 
> understand it (and I might be behind the times here, please do correct 
> me if I'm wrong), acpid reads ACPI-specific power event notifiers, such 
> as button pressed, thermal limit exceeded, etc. from the kernel via 
> /proc, and acpid executes scripts in /etc/acpi/ to handle the event. 
> Some of the embedded developers I deal with have asked for similar 
> notifiers in a non-ACPI context.  The system suspend/resume notifiers 
> discussed in this thread could be thought of as a general form of "sleep 
> button pressed" type event.  (And I now realize it may have been better 
> to implement and pitch it as such.)

Well, yes, generic "sleep button pressed" notifier is certainly better
idea. For example it does not have to be synchronous. I actaully like
that.

Is input subsystem any good? It might be as simple as defining keys
for POWER/SLEEP buttons and routing acpi events through even
subsystem...

								Pavel
-- 
When do you have heart between your knees?

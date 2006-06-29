Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWF2RPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWF2RPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWF2RPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:15:44 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:22788 "EHLO
	smtp-vbr17.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751040AbWF2RPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:15:43 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: swsusp problems with 2.6.17-1.2139_FC5
From: Johan Vromans <jvromans@squirrel.nl>
Date: Thu, 29 Jun 2006 19:15:40 +0200
Message-ID: <m2irmj9937.fsf@phoenix.squirrel.nl>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp has problems resumeing after upgrading my Acer Travelmate
4001WLMi from 2.6.16 to 2.6.17. Note that I'm running a Fedora 5
kernel, with the ATI proprietary video driver.
On this 512Mb system, I have typically 60% of memory in use when I go
into hibernate. This is with X, wm, Emacs, some xterms, wireless.

With 2.6.16, when I initiate a hibernate with

  echo shutdown > /sys/power/disk; echo disk > /sys/power/state

I get switched back to vt1(?), the "stopping tasks" messages, and so
on, until the system shuts down in ordinary fashion. 

With 2.6.17, when I initiate the hibernate, I get no apparent reaction
(although the flashing disk led reveals what's going on) and the
system shuts down.

Upon reboot, I get

  Trying to resume from /dev/hda4
  Resuming from /dev/hda4.
  Attempting manual resume

and then the console does a half-hearted attemtp to restore X and
freezes. The system is alive, I can login via the network. Restarting
the X server (from another tty, the console remains stuck) seems to
'cure' the problem. However, when exiting X the console stays
connected to vt7 and needs to be put back to vt1 manually.

It seems to be a problem with the video switching out/in X. 
When I change to a vt out of X, then suspend/resume seems to give no
problem and after resume I can switch back to vt7 into X.

Any suggestions to cure this problem? Is it a know regression?

Thanks,
        Johan


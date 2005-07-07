Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVGGM7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVGGM7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVGGM55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:57:57 -0400
Received: from [203.171.93.254] ([203.171.93.254]:52905 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261449AbVGGMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:55:06 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DqVp3-00064l-00@chiark.greenend.org.uk>
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz>
	 <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost>
	 <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
	 <E1DqV7G-0004PX-00@chiark.greenend.org.uk>
	 <1120738525.4860.1433.camel@localhost>
	 <E1DqVp3-00064l-00@chiark.greenend.org.uk>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120740978.4860.1529.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Jul 2005 22:56:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-07-07 at 22:49, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > On Thu, 2005-07-07 at 22:04, Matthew Garrett wrote:
> >> Do you implement the entire swsusp userspace interface? If not, removing
> >> it probably isn't a reasonable plan without fair warning.
> > 
> > I'm not suggesting removing the sysfs interface or replacing system to
> > ram - just the suspend to disk part.
> 
> Right, so you support the resume from disk trigger in sysfs and the
> /proc/acpi/sleep interface? If suspend2 is a complete dropin replacement
> then I'm much happier with the idea of dropping swsusp, but I don't want
> to have to tie suspend/resume scripts to kernel versions.

Suspend2 currently has a proc entry to do the same, but I can easily
hook into the sysfs code. /proc/acpi/sleep is already taken care of, as
is the reboot handler. Suspend2 currently uses resume2= so as to not
conflict with swsusp, but that can be changed too. I always to my utmost
to ease the pain for other users. If something doesn't work the way you
want, just tell me and (assuming it's reasonable), I'll fix it.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 


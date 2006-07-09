Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWGIAGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWGIAGF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWGIAGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:06:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44809 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030426AbWGIAGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:06:03 -0400
Date: Sun, 9 Jul 2006 02:06:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Miles Lane <miles.lane@gmail.com>
Subject: ACPI_DOCK bug: noone cares
Message-ID: <20060709000601.GA13938@stusta.de>
References: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com> <20060625200953.GF23314@stusta.de> <a44ae5cd0606251313n5e7654f3t652df65e811325b5@mail.gmail.com> <20060625204039.GG23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625204039.GG23314@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 10:40:39PM +0200, Adrian Bunk wrote:
> On Sun, Jun 25, 2006 at 01:13:04PM -0700, Miles Lane wrote:
> 
> > Should I attach my entire .config file in the future?  It's large enough 
> > that
> > I try to trim it to avoid bloating people's inboxes.
> 
> I'm often trying to reproduce compile errors, and it's always a pain in 
> the ass when I have to construct a complete .config based on such a 
> fragment instead of simply using the complete .config of the reporter.
> 
> And people for whom a few kB would matter wouldn't subscribe to 
> linux-kernel...
> 
> > Yes, that's right.  It is compiled as a module.  So this just needs
> > a tweaked config rule, right?
> 
> It would be a solution to let HOTPLUG_PCI_ACPI depend on
> (ACPI_DOCK || ACPI_DOCK=n), or the #if in 
> include/acpi/acpi_drivers.h could be changed to
> #if defined(CONFIG_ACPI_DOCK) || (defined(CONFIG_ACPI_DOCK_MODULE) && defined(MODULE))
> 
> Which one suits better the intention is better is a question Kristen has 
> to answer.


Two weeks ago, we had:
- a bug report
- a detailed description how to possibly fix this issue

What we did NOT have was:
- any reaction by the patch author or any maintainer
  (although with the exception of Linus, the recipients of the problem
   description were exactly the same as the ones in this email)

A few days later, the patch that includes this bug was included in 
Linus' tree.

Two weeks later, the bug is still present in both latest -mm and Linus' 
tree.

Linus, please do a
  git-revert a5e1b94008f2a96abf4a0c0371a55a56b320c13e

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


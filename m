Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267677AbTGHVKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbTGHVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:10:12 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:28806 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S267677AbTGHVKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:10:08 -0400
Date: Tue, 8 Jul 2003 15:59:45 -0400
From: Ben Collins <bcollins@debian.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SBP2 and IEEE1394 in 2.5.74
Message-ID: <20030708195945.GE5830@phunnypharm.org>
References: <1057698811.6911.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057698811.6911.8.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:13:31PM -0600, Bob Gill wrote:
> I have at long last had reasonable success building 2.5.74 (I configured
> ACPI out, and along with it went scheduling_while_atomic).  The only
> issue now is firewire, specifically modules SBP2 and IEEE1394.  I looked
> at the source and found it to be amazingly small (not many files and
> none larger that about 30 bytes).  Is there any timeline when these will
> be joining the kernel?  I would switch over to using 2.5.X tomorrow if
> these could be completed/working.  Is there a 2.4.X retrograde patch
> that could be applied to make these work before the complete 2.5.X
> version is completed?  Thanks,

ieee1394, sbp2 and all of the subsystem is in working order. What
problem are you having?

If all the files in drivers/ieee1394 are less than 30 bytes, I think you
have some other problem.

Also, 2.5.74 stock has a problem in sbp2.c. It needs the linux/pci.h
include added (already fixed in Linus' tree).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

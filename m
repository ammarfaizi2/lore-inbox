Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbTKNR2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264626AbTKNR2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:28:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:16568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264625AbTKNR2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:28:01 -0500
Date: Fri, 14 Nov 2003 09:23:19 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no Kconfig in "kernel" subdir?
Message-Id: <20031114092319.5260bd01.rddunlap@osdl.org>
In-Reply-To: <3FB50B4D.1000300@nortelnetworks.com>
References: <3FB50B4D.1000300@nortelnetworks.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003 12:05:17 -0500 Chris Friesen <cfriesen@nortelnetworks.com> wrote:

| I was adding a new general syscall the other day, and it struck me as 
| odd that there is no Kconfig in the "kernel" subdirectory.
| 
| A quick search shows 36 separate config options being used in that 
| subdirectory (stuff like PREEMPT, SMP, FUTEX, HOTPLUG, SYSCTL, etc). 
| Why is there no Kconfig for it?  As it stands, all of these have to be 
| copied and pasted in every single arch.  This seems odd.

In several cases I expect that you are correct.
In some cases, general config options are now going into init/Kconfig.

| Would people be open to a series of patches that create a new Kconfig 
| and start moving generic stuff to it?  Or are these things really 
| arch-specific enough to warrent massive duplication?

I consider PREEMPT and SMP arch-specific, not generic.

Will init/Kconfig do what you want?

--
~Randy
MOTD:  Always include version info.

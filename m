Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUAWHei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266530AbUAWHei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:34:38 -0500
Received: from gprs157-118.eurotel.cz ([160.218.157.118]:14720 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265708AbUAWHeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:34:36 -0500
Date: Fri, 23 Jan 2004 08:34:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp vs  pgdir
Message-ID: <20040123073426.GA211@elf.ucw.cz>
References: <1074833921.975.197.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074833921.975.197.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've been bored enough today to hack on getting the current
> pmdisk/swsusp up on ppc.  The required arch code should be almost
> identical.
> 
> However, when looking at it, I didn't fully understand how you
> actually ensure your page mappings aren't beeing blown away
> behind your back during the copy operation on resume, but since
> my knowledge of x86 is almost inexistant, I didn't decipher this
> from the source code. Could you explain a bit ?
> 
> The thing is that you seem to point to the swapper pgdir during
> the copy, that is the kernel page tables, but those are beeing
> wiped out during the copy potentially, no ?

We test that CPU has PSE feature. That means kernel is mapped using
4MB page tables, and I do not have to care about page tables at
all.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

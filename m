Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTDNVCt (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTDNVCs (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:02:48 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:20419 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263748AbTDNVBt (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:01:49 -0400
Date: Mon, 14 Apr 2003 22:13:15 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 'what to expect' document.
Message-ID: <20030414211311.GA11160@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Michael Buesch <fsdeveloper@yahoo.de>, linux-kernel@vger.kernel.org
References: <20030414193138.GA24870@suse.de> <200304142308.03553.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142308.03553.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:08:03PM +0200, Michael Buesch wrote:

 > Will it be implemented in future to taint the kernel if CPU is overclocked?

Theoretically possible on most CPUs, but it's not that simple.
- Some CPUs don't encode the necessary bits to tell you their
  current multiplier/FSB
- Some CPUs don't encode the necessary info to tell you the speed
  the CPU should be running at.

Which leaves those that do have the necessary info..
Which is different per vendor, per family, per model.
That's a lot of tests, and it's not a walk in the park to get
it all right, which is probably why no-one has done it yet.

Alan tried it in the 2.4.early-ac stage, but gave up on it
after a while, after getting lots of reports of it not working
out as planned..

		Dave


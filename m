Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTHYJgg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTHYJgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:36:36 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:11941 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261903AbTHYJfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:35:50 -0400
Date: Mon, 25 Aug 2003 11:35:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, aj@suse.de,
       mark.langsdorf@amd.com, richard.brunner@amd.com
Subject: Re: Cpufreq for opteron
Message-ID: <20030825093556.GA3020@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C080EF00E@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF00E@txexmtae.amd.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It appears to me that the BUG_ON() macro will take the machine
> down ? The BUG_ON() checks in this code (a sample below, but 
> this applies to all of the driver) are not fatal conditions - 
> execution can continue if an error is returned. Taking the 
> machine down to report on a non-fatal condition seems somewhat 
> rude.

It is somewhat rude, but it makes sure that the error gets fixed. [And
it also appears safer to me: if we know error already happened we opt
to stop the system so nothing bad happens.]

Questions:

1) is it possible to do hardware damage from powernow-k8 driver?

2) should some of those checks be fatal?

3) for nonfatal checks, is it possible to use WARN_ON() -- warn and
continue?

4) given good hardware and debugged driver, will any of those
BUG_ON()s ever trigger?

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

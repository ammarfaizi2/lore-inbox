Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUA1PqB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUA1Pol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:44:41 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:37763 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266056AbUA1PlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:41:14 -0500
Date: Wed, 28 Jan 2004 16:41:12 +0100
From: Martin Mares <mj@ucw.cz>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] PCI Scan all functions
Message-ID: <20040128154112.GA6108@ucw.cz>
References: <1075222501.1030.45.camel@magik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075222501.1030.45.camel@magik>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> There are some arch, like PPC64, that need to be able to scan all the
> PCI functions.  The problem comes in on a logically partitioned system
> where function 0 on a PCI-PCI bridge is assigned to one partition and
> say function 2 is assiged to another partition.  On the second
> partition, it would appear that function 0 does not exist, but function
> 2 does.  If all the functions are not scanned, everything under function
> 2 would not be detected.

Enabling scan of all functions globally is probably going to cause troubles,
because there are single-function devices which respond to all function
numbers. You need to enable this quirk selectively.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"God doesn't play dice."    -- Albert Einstein

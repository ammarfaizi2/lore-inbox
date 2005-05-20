Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVETAeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVETAeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 20:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVETAeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 20:34:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:51171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261153AbVETAeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 20:34:07 -0400
Date: Thu, 19 May 2005 17:34:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
cc: linux-kernel@vger.kernel.org, techsupport@tyan.com, support@tyan.de,
       Andrew Morton <akpm@osdl.org>, gl@fenedex.nl, land@hetlageland.nl,
       hans@sww.nl, sww@sww.nl
Subject: Re: Tyan Opteron boards and problems with parallel ports
In-Reply-To: <Pine.LNX.4.44.0505200121410.10661-100000@hubble.stokkie.net>
Message-ID: <Pine.LNX.4.58.0505191727030.2322@ppc970.osdl.org>
References: <Pine.LNX.4.44.0505200121410.10661-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 May 2005, Robert M. Stockmann wrote:
> 
> All problems of Tyan Opteron based machines silently locking up during 
> installation and/or during normal operation of running Linux, both 
> 32bit and 64bit, without any display of kernel panic of any other 
> logging method, seem to be solved when switching off the Parallel Port 
> inside its BIOS.

Can you do an install with the thing turned off, and then 
 - compile the kernel with CONFIG_PCI_DEBUG
 - boot with the parallel port enabled, and send as much of the bootup 
   output (and /proc/iomem and /proc/ioport) as possible
 - boot with the parallel port disabled, and send the same output for that 
   working case.

I have no clue why the parallel port should matter, but it could change 
some resource allocation issues.

		Linus

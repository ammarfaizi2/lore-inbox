Return-Path: <linux-kernel-owner+w=401wt.eu-S1751832AbWLNIes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWLNIes (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWLNIes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:34:48 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:48163 "EHLO jdi.jdi-ict.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbWLNIer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:34:47 -0500
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 03:34:47 EST
Date: Thu, 14 Dec 2006 09:15:39 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, npiggin@suse.de, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <Pine.LNX.4.58.0612071328030.9115@jdi.jdi-ict.nl>
Message-ID: <Pine.LNX.4.58.0612140912010.30202@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org> <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl> <20061206074008.2f308b2b.akpm@osdl.org>
 <Pine.LNX.4.58.0612070940590.28683@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612071328030.9115@jdi.jdi-ict.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Thu, 14 Dec 2006 09:15:41 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'll put a .config and a dmesg of the machine booting at 
> > http://www.jdi-ict.nl/plain/ for those who want to look at it.
> 
> dmesg : http://www.jdi-ict.nl/plain/lnx01.dmesg
> Kernel config : http://www.jdi-ict.nl/plain/lnx01.config

Hmm.. Switching CONFIG_HZ from 1000 to 250 seems to 'fix' the problem. 
I haven't seen the issue in nearly a week now. This makes Andrew's theory 
about missing interrupts very likely.

Andrew / others : Is there a way to find out if it *is* missing 
interrupts ?


Regards,


	Igmar

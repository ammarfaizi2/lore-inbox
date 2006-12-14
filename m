Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbWLNImd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLNImd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWLNImd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:42:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60350 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbWLNImc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:42:32 -0500
Date: Thu, 14 Dec 2006 00:42:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
Message-Id: <20061214004213.13149a48.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0612140912010.30202@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
	<20061130212248.1b49bd32.akpm@osdl.org>
	<Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl>
	<20061206074008.2f308b2b.akpm@osdl.org>
	<Pine.LNX.4.58.0612070940590.28683@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612071328030.9115@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612140912010.30202@jdi.jdi-ict.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 09:15:39 +0100 (CET)
Igmar Palsenberg <i.palsenberg@jdi-ict.nl> wrote:

> 
> > > I'll put a .config and a dmesg of the machine booting at 
> > > http://www.jdi-ict.nl/plain/ for those who want to look at it.
> > 
> > dmesg : http://www.jdi-ict.nl/plain/lnx01.dmesg
> > Kernel config : http://www.jdi-ict.nl/plain/lnx01.config
> 
> Hmm.. Switching CONFIG_HZ from 1000 to 250 seems to 'fix' the problem. 
> I haven't seen the issue in nearly a week now. This makes Andrew's theory 
> about missing interrupts very likely.
> 
> Andrew / others : Is there a way to find out if it *is* missing 
> interrupts ?
> 

umm, nasty.  What's in /proc/interrupts?

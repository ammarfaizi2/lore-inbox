Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVBCLRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVBCLRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVBCLOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:14:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62852 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263006AbVBCLII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:08:08 -0500
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ee21rh@surrey.ac.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <1107299901.5624.28.camel@gaston>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>
	 <pan.2005.02.01.20.21.46.334334@surrey.ac.uk>
	 <1107299901.5624.28.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107332790.14787.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Feb 2005 10:03:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-02-01 at 23:18, Benjamin Herrenschmidt wrote:
> On Tue, 2005-02-01 at 20:22 +0000, Richard Hughes wrote:
> > On Tue, 01 Feb 2005 12:57:33 +0100, Michael Brade wrote:
> I suspect in your case, it's reading "ff", which indicates either that
> there is no hardware where the kernel tries to probe, or that there is
> bogus IDE interfaces which don't properly have the D7 line pulled low so
> that BUSY appears not set in absence of a drive.
> 
> I'm not sure how the list of intefaces is probed on this machine, that's
> probably where the problem is.

Known, fixed

There is a patch that allows probing for ISA ide4,5,6 etc only if there
is
no PCI bus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVIVNuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVIVNuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbVIVNuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:50:22 -0400
Received: from odin2.bull.net ([192.90.70.84]:59903 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1030326AbVIVNuW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:50:22 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT bug with 2.6.13-rt4 and 3c905c tornado
Date: Thu, 22 Sep 2005 15:54:02 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200509201046.17818.Serge.Noiraud@bull.net> <20050920085532.GA19807@elte.hu>
In-Reply-To: <20050920085532.GA19807@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509221554.02765.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mardi 20 Septembre 2005 10:55, Ingo Molnar wrote/a écrit :
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> > Hi
> >
> > 	This driver works perfectly if you insert the physical card on a
> > PCI slot. If you insert this same card on a PCI-X slot, we got the
> > following problem : When you type "modprobe 3c59x", the system freeze.
> >
> > Has someone already test this ?
> >
> > This card works perfectly on the same PCI-X slot with a non RT kernel.
> > Do you need some more info ?
>
> use serial logging and the NMI watchdog to debug hard lockups (see the
> info below). Use CONFIG_DETECT_SOFTLOCKUP=y to detect soft lockups.
> Generally the use of debugging options can help as well. Here's a 'full'
> debugging kernel:

Big deal !
How can I debug this problem ?
If the kernel has no debug option, modprobe freeze the machine.
If the kernel has debug option, modprobe works correctly and the card works 
perfectly. I compile one kernel and make recursively listing trough nfs
I got 140 millions nfs requests without problem.

I could have kgdb, but it doesn't work. I'm not sure it helps me. I think it's 
a timing problem somewhere in the pci driver.


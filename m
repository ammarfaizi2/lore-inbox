Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266552AbUFVDyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266552AbUFVDyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 23:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUFVDyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 23:54:43 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:52693 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266552AbUFVDyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 23:54:40 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Question on using MSI in PCI driver
X-Message-Flag: Warning: May contain useful information
References: <52lligqqlc.fsf@topspin.com> <40D7AC9B.5040409@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 21 Jun 2004 20:54:38 -0700
In-Reply-To: <40D7AC9B.5040409@pobox.com> (Jeff Garzik's message of "Mon, 21
 Jun 2004 23:50:51 -0400")
Message-ID: <52659kqmbl.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 03:54:38.0205 (UTC) FILETIME=[A3AC5AD0:01C4580C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> You are breaking new ground by adding MSI support to a
    Jeff> driver.  I thank you for this -- alot -- but you should
    Jeff> realize there will probably be a little bit of PCI core work
    Jeff> necessary in order to get things the way you want them.

Yes, I noticed only a couple of hotplug drivers seem to be using MSI,
and no one is using multiple vector support.  My motivation is
twofold.  First, because my device can generate interrupts for
different reasons, and I'm noticing that doing the MMIO read to the
cause register is taking a lot of time, so I'm wondering whether
avoiding this by having separate MSI-X messages will be a win.
Second, for the fun of trying it :)

    Jeff> Feel free to propose changes to the PCI core to accomodate
    Jeff> your MSI driver.

First patch coming up now :)

 - Roland



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUI0Qu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUI0Qu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 12:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUI0Qu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 12:50:27 -0400
Received: from digitalimplant.org ([64.62.235.95]:7058 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266574AbUI0Qu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 12:50:26 -0400
Date: Mon, 27 Sep 2004 09:50:21 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Oliver Neukum <oliver@neukum.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: suspend/resume support for driver requires an external firmware
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403>
Message-ID: <Pine.LNX.4.50.0409270948570.32506-100000@monsoon.he.net>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Sep 2004, Zhu, Yi wrote:

> Oliver Neukum wrote:
> > Am Freitag, 24. September 2004 08:16 schrieb Zhu, Yi:
> >> Choice 3? or I missed something here?
> >
> > If the user requests suspension, why can't he transfer the
> > firmware before he does so? Thus the firmware would be in ram
> > or part of the image read back from disk.
>
> Do you suggest before user echo 4 > /proc/acpi/sleep, [s]he must
> do something like cat /path/of/firmware > /proc/net/ipw2100/firmware?

Why not just suspend the device first, then enter the system suspend
state; then on resume, resume the device after control has transferred
back to userspace. That way, the driver can load the firmware from the
disk, and we don't have to worry about it in the kernel. Automate with a
script, and never worry about it again. :)


	Pat

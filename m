Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbTFMQWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbTFMQWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:22:53 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:24727 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265436AbTFMQW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:22:27 -0400
Date: Fri, 13 Jun 2003 12:35:47 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mark Watts <m.watts@eris.qinetiq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: HyperThreading not working in 2.4.21-rc6-ac2
In-Reply-To: <200306130949.24402.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.44.0306131234240.2856-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003, Mark Watts wrote:

> The following is a dmesg from a Dell PowerEdge 2650 server with 2 2.4Ghx
> HT capable processors. To the best of my knowledge, I have HT enabled in
> the bios but I still only see the physical processors (no siblings) even
> though the cpus are numbered as if I have siblings.
> 
> Any suggestions?

> Kernel command line: auto BOOT_IMAGE=2421rc6ac2 ro root=801 devfs=mount 
> hda=ide-scsi acpi=off
               ^^^^^^^^

The -ac kernel drops acpitable.c, which used to detect things
like irq routing and HT "evil twin" CPUs and instead upgrades
the ACPI subsystem. I suspect you need a different ACPI setting,
though I'm not sure what it would be.


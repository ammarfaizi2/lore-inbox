Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUF1CXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUF1CXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 22:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUF1CXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 22:23:41 -0400
Received: from bay16-f22.bay16.hotmail.com ([65.54.186.72]:47108 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264629AbUF1CXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 22:23:39 -0400
X-Originating-IP: [64.81.213.196]
X-Originating-Email: [dinoklein@hotmail.com]
From: "Dino Klein" <dinoklein@hotmail.com>
To: bjorn.helgaas@hp.com
Subject: Re: [PATCH 2.6.7] Parallel port detection via ACPI
Date: Sun, 27 Jun 2004 23:23:38 -0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F22JDVK3aXvlc0000da11@hotmail.com>
X-OriginalArrivalTime: 28 Jun 2004 02:23:38.0705 (UTC) FILETIME=[EC094410:01C45CB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
I have one question about using acpi_register_gsi() - this is an ia64 only 
thing, right?
Thing is, that I remember an exchange on the acpi mailing list mentioning 
that there is no legacy hardware on ia64 systems; wouldn't that also include 
the parallel port?




>From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>To: Dino Klein <dinoklein@hotmail.com>
>Subject: Re: [PATCH 2.6.7] Parallel port detection via ACPI
>Date: Tue, 22 Jun 2004 17:42:36 -0600
>
>Nice start at this!  As you note, it needs a little work.  Here are
>a couple things I noticed:
>
>	- the ACPI stuff should be under #ifdef CONFIG_ACPI
>	- the IRQ should be fed through acpi_register_gsi() (a new
>	  interface that showed up in BK a few days ago)
>	- there are IRQ and extended IRQ structures -- maybe
>	  should be extended to handle both?
>	- seems like it'd be nice to arrange it so we look in
>	  ACPI first, then fall back to previous detection if
>	  that fails (probably with a boot-time option to disable
>	  the ACPI detection in case the firmware is buggy)
>
>Again, good work!  I'm glad to see us starting to take advantage
>of this stuff.
>
>Bjorn

_________________________________________________________________
MSN Messenger: instale grátis e converse com seus amigos. 
http://messenger.msn.com.br


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTJKMAZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 08:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbTJKMAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 08:00:25 -0400
Received: from mail2.scram.de ([195.226.127.112]:57355 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S263290AbTJKMAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 08:00:24 -0400
Date: Sat, 11 Oct 2003 13:59:42 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@ayse.bocc.de
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/14] firmware update for av7110 dvb driver
In-Reply-To: <1065624307.5470.242.camel@pegasus>
Message-ID: <Pine.LNX.4.58.0310111355380.24459@ayse.bocc.de>
References: <10656197272107@convergence.de> <1065624307.5470.242.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

> the request_firmware() framework is part of Linux 2.4 and 2.6 and so for
> most drivers the firmware file can be loaded from userspace through proc
> or sysfs. Please take a look at it.

Is there a way to use this for ISA devices? I'd like to convert my
tms380tr request_firmware() as i want to get rid of hardcoded, binary
only firmware. However, there is no struct device for ISA devices (and
in particular, no bus id) and unlike the old style PCI DMA mapping, which
accepts NULL as pci_dev and assumes ISA in this case, request_firmware()
absolutely needs the parameter...

--jochen

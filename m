Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUEaXwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUEaXwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 19:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEaXwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 19:52:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:51899 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264633AbUEaXwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 19:52:38 -0400
Subject: Re: misc device suspend/resume new model
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Florian Lohoff <flo@rfc822.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040531225744.GA6682@paradigm.rfc822.org>
References: <20040531225744.GA6682@paradigm.rfc822.org>
Content-Type: text/plain
Message-Id: <1086047542.1996.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Jun 2004 09:52:23 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 08:57, Florian Lohoff wrote:
> Hi,
> what is the preferred way of getting suspend/resume events (new model)
> with misc devices registered via misc_register.
> 
> Registering a sys_driver/device/class ?

The suspend/resume events aren't propagated from the functional
interface/class (which misc is), but from the bus binding. So you
should get them from whatever bus your device is on, that is via
a pci_dev for PCI devices, etc...

Ben.



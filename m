Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUKCNqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUKCNqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUKCNqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:46:08 -0500
Received: from knserv.hostunreachable.de ([212.72.163.70]:10138 "EHLO
	mail.hostunreachable.de") by vger.kernel.org with ESMTP
	id S261598AbUKCNp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:45:57 -0500
Message-ID: <33093.192.35.17.30.1099489553.squirrel@config.hostunreachable.de>
Date: Wed, 3 Nov 2004 14:45:53 +0100 (CET)
Subject: IP Layer on VME-Bus
From: "H. Wiese" <7.e.Q@syncro-community.de>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: 7.e.Q@syncro-community.de
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we develop a driver which enables us to use an ip layer on top of the vme-bus
technology. Now we got some problems with coding the driver. We already have
an old version of this driver (called "dpn") which works well but has no use
for us anymore since we upgraded our system from kernel 2.2.14 to 2.6.7. So
now we have to create a new driver.

The old driver established the ip layer by accessing the dual port ram of
the VME bus, which is based on a Tundra Universe II Chipset. This enables
us to transfer data, ping etc. between active VME-modules using the
VME-bus. Very useful.

Well, the problem we will surely run into is: will the driver work as fine as
the old one if we only recreate the initialization functions working with the
new kernel function set (e.g. wait_event_interruptible instead of
interruptible_sleep_on etc.), copy the essential functions from the old
driver
to the new one and alter them a little to work with the new kernel functions?
Or is there anything else to put an eye on?


Thankx a lot

kind regards
Hendrik

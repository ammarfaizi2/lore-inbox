Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVAPNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVAPNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVAPNwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:52:38 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:49616 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262503AbVAPNw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:52:28 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 0/13] remove cli()/sti() in drivers/char/*
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:52:23 -0600
Date: Sun, 16 Jan 2005 07:52:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches removes the last cli()/sti()/save_flags()/restore_flags()
function calls in drivers/char.

Diffstat output:
 epca.c                        |  158 +++++++++++++++++-------------------------
 esp.c                         |  139 ++++++++++++++++++------------------
 ftape/lowlevel/ftape-format.c |    2
 ftape/lowlevel/ftape-io.c     |    6 -
 generic_serial.c              |    6 -
 ip2main.c                     |   12 +--
 istallion.c                   |  121 +++++++++++++-------------------
 ite_gpio.c                    |    5 -
 moxa.c                        |   25 ++----
 pcxx.c                        |  140 +++++++++++++++----------------------
 riscom8.c                     |   89 +++++++++++------------
 serial_tx3912.c               |   36 ++++-----
 stallion.c                    |  146 +++++++++++++++-----------------------
 13 files changed, 382 insertions(+), 503 deletions(-)

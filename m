Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVBZMzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVBZMzq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVBZMzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 07:55:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:40630 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261183AbVBZMzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 07:55:42 -0500
Date: Sat, 26 Feb 2005 13:55:33 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __devinitdata in parport_pc
Message-ID: <20050226125531.GA7271@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parport_init_mode is referred to in int __devinit sio_via_probe().

Andries

diff -uprN -X /linux/dontdiff a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	2005-02-26 12:13:30.000000000 +0100
+++ b/drivers/parport/parport_pc.c	2005-02-26 14:06:23.000000000 +0100
@@ -2488,7 +2488,7 @@ static int __devinit sio_ite_8872_probe 
 
 /* VIA 8231 support by Pavel Fedin <sonic_amiga@rambler.ru>
    based on VIA 686a support code by Jeff Garzik <jgarzik@pobox.com> */
-static int __initdata parport_init_mode = 0;
+static int __devinitdata parport_init_mode = 0;
 
 /* Data for two known VIA chips */
 static struct parport_pc_via_data via_686a_data __devinitdata = {

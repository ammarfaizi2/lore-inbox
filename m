Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUCOFZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCOFZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:25:25 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:48001 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262248AbUCOFZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:25:23 -0500
Date: Mon, 15 Mar 2004 00:21:47 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315002146.GD5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com> <20040315001029.GB5972@neo.rr.com> <20040315001519.GC5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315001519.GC5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PNP] remove __init from system.c

This patch is from "Randy.Dunlap" <rddunlap@osdl.org>

// Linux 2.6.4-rc2
// These 2 functions shouldn't be __init for general PNP use.

diffstat:=
 drivers/pnp/system.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Naurp ./drivers/pnp/system.c~pnp_init ./drivers/pnp/system.c
--- ./drivers/pnp/system.c~pnp_init	2004-02-17 19:59:59.000000000 -0800
+++ ./drivers/pnp/system.c	2004-03-07 15:14:30.000000000 -0800
@@ -21,7 +21,7 @@ static const struct pnp_device_id pnp_de
 	{	"",			0	}
 };

-static void __init reserve_ioport_range(char *pnpid, int start, int end)
+static void reserve_ioport_range(char *pnpid, int start, int end)
 {
 	struct resource *res;
 	char *regionid;
@@ -49,7 +49,7 @@ static void __init reserve_ioport_range(
 	return;
 }

-static void __init reserve_resources_of_dev( struct pnp_dev *dev )
+static void reserve_resources_of_dev( struct pnp_dev *dev )
 {
 	int i;
 

 

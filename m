Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWCBTnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWCBTnV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWCBTnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:43:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:13461 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752054AbWCBTnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:43:20 -0500
Date: Thu, 2 Mar 2006 13:31:08 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Andrew Morton <akpm@osdl.org>, <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: removal of EXPORT_SYMBOL(insert_resource)?
Message-ID: <Pine.LNX.4.44.0603021316001.307-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a situation that I believe warrants leaving insert_resource as an 
exported API.

I've got a bus implementation that it done as a module.  While I'm more 
than happy to provide this bus implementation to be included in the 
mainline, I dont think it makes much sense to do so.  The code is only 
useful to an extremely small handful of people.  If we want to clutter the 
kernel with it I'm happy to provide a patch for it.

The situation I have is a FPGA connect over PCI.  The FPGA implements a 
number of different "functions" but uses PCI more like an SoC bus than a 
true PCI device.  Anyways, in some discussions with gregkh, it was 
suggested the best thing was to create a new bus type that the "fpga" 
drivers would bind to.

I use insert_resource to handle registering the MMIO regions for each 
device (similar to how platform devices are registered).

- kumar


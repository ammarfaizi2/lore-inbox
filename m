Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTEEQV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTEEQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:21:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:60345 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263607AbTEEQUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:20:25 -0400
Date: Mon, 05 May 2003 09:32:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 653] New: i386 NUMA does not work on non x440/Summit
Message-ID: <9770000.1052152343@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=653

           Summary: i386 NUMA does not work on non x440/Summit
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: ak@suse.de


When a summit CONFIG_DISCONTIGMEM kernel is booted on a non summit/numa
4cpu box it'll not boot, hanging before console init

Enabling early printk shows that it gets to the numa memory init and then
dies with an endless "unknown interrupt" loop.

Looks like the srat discontigmem init fallback path does not work.

This is also a problem with the dynamic subarchitecture path (only in -mm)
when CONFIG_NUMA is enabled. It disallows to build a generic generic
CONFIG_NUMA kernel.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVKRASg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVKRASg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVKRASg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:18:36 -0500
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:45292 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S964922AbVKRASf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:18:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: question about driver built-in kernel
Date: Thu, 17 Nov 2005 17:18:34 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC501A31910@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question about driver built-in kernel
Thread-Index: AcXr1EDVuNTRj+e7QMyAOpBcIxCIsgAASNew
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2005 00:18:34.0878 (UTC) FILETIME=[9D4121E0:01C5EBD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have two driver modules to support our hardware for some applications. Both modules worked fine as loadable modules. Now I need to build both drivers in kernel 2.6.11-8. I have changed configuration file and make file. Both drivers are built OK with kernel together. Now I have two concerns:

1, Because both drivers were loaded as module before, the entry point for both driver is "init_module()". Since both drivers are built in kernel, the entry name is conflicting. Changing one entry point name will make driver built OK. However, I am concerned that loading kernel will not pick up the driver with changed entry point name. What is the best way to handle this situation?

2, One of built-in driver requires to be loaded before the second one. Because these two drivers are not belong to any existing group, such as network, scsi, where is the best place these two driver can be specified for loading sequence? I checked init.d and rc* files but did not figure out proper place to handle the requirement.

Many Thanks!

Eddie

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUFSDFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUFSDFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 23:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265749AbUFSDFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 23:05:49 -0400
Received: from mta3.wss.scd.yahoo.com ([66.218.85.34]:17829 "EHLO
	mta3.wss.scd.yahoo.com") by vger.kernel.org with ESMTP
	id S265740AbUFSDFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 23:05:46 -0400
From: "jeff palmer" <jeff@triggerinc.com>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Patch for multiport serial MOXA boards - kernel.2.4.25 - mxser.c
Date: Fri, 18 Jun 2004 23:05:52 -0400
Message-ID: <01a601c455aa$54d62c60$3201080a@alien25687>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.2.4.25
The moxa drivers currently do not work with devfs support in linux. Most
people are migrating to devfs, as I have. These are the lines that need
fixed in mxser.c. Devfs attempts to create the device when it’s registered,
so you cannot register all the ports with the same name. The fix is pretty
obvious and I hope this email makes it to the right person. Any questions,
just let me know. Thanks.
 
mxser.c.patch.kernel.2.4.25
530c530
<       mxvar_sdriver.name = "ttyM";
---
>       mxvar_sdriver.name = "ttyM%d";
565c565
<       mxvar_cdriver.name = "cum";
---
>       mxvar_cdriver.name = "cum%d"; 
 
Jeffery Palmer
Project Development
Trigger, Inc.
954.709.7232
 


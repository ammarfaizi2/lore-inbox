Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbULVEpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbULVEpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 23:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbULVEpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 23:45:30 -0500
Received: from wip-ec-wd.wipro.com ([203.101.113.39]:15257 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S261231AbULVEp0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 23:45:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Query on module dependency handling in IrDA network drivers
Date: Wed, 22 Dec 2004 10:15:23 +0530
Message-ID: <93AC2F9171509C4C9CFC01009A820FA001FDA8AD@blr-ec-msg05.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Query on module dependency handling in IrDA network drivers
Thread-Index: AcTnZDd8hmS27Nj4QXma/cSXqgI1GAAfc+2A
From: <manjunathg.kondaiah@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Dec 2004 04:45:20.0155 (UTC) FILETIME=[0A6956B0:01C4E7E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All,

This is with reference to handling of module dependencies in IrDA
network drivers on 2.6.10-rc3.

My understanding is that the lower most drivers (in the IrDA stack which
will be platform dependent) should not be doing a try_module_get or a
module_put in itself. My device however is not a hot-pluggable device,
but I would like to dynamically load and unload the lower layer IrDA
driver. If I am not using try_module_get in my lower layer driver, the
issue that I am facing is: When the irda0 (in my case) is up and data is
under transmission and I do an rmmod of the lower layer driver, the
driver is being removed (the transfer stops meanwhile). This does not
seem to be a proper behavior (If this is an expected behavior, could
some one explain why this is so?). I would rather expect the rmmod to
tell me that the module is busy and refuse to remove the module.

Regards,
Manjunath

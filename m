Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWH3Pdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWH3Pdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWH3Pdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:33:38 -0400
Received: from mail.zeugmasystems.com ([192.139.122.66]:50834 "EHLO
	zeugmasystems.com") by vger.kernel.org with ESMTP id S1751088AbWH3Pdi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:33:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How to prevent an object file from being thrown away?
Date: Wed, 30 Aug 2006 08:33:36 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D365BFD@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to prevent an object file from being thrown away?
Thread-Index: AcbMSailKKLa3fWAS/OVMdxUB1NE+Q==
From: "Kaz Kylheku" <kaz@zeugmasystems.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an object file which contains only static objects and functions.
One of them is marked __init, and annotated with a late_initcall().
However, the file, which is added to a lib.a archive, is still
ultimately thrown away by the linker. 

I can solve it with a dummy reference to a symbol in that file from
another module, but is there some "officially blessed" Linux kernel
Makefile trick to make the linker do the
--whole-archive/--no-whole-archive around a particular lib.a?




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTGWOAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270328AbTGWOAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:00:54 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:33940 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270325AbTGWOAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:00:43 -0400
Subject: Accessing serial port from kernel module
Date: Wed, 23 Jul 2003 16:15:17 +0200
Message-ID: <8FB92279C69C2944B325B4BD227401790156B8@nt-server.danziger.local>
X-MS-Has-Attach: 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-TNEF-Correlator: 
Thread-Topic: Accessing serial port from kernel module
Thread-Index: AcNRJNfQFFJpK6+xR9aGOPlMxtgJIw==
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
From: =?iso-8859-1?Q?Kurt_H=E4usler?= <Kurt@fub-group.de>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am writing a kernel module device driver for a special sort of modem that doesn't use the standard AT command set.

Basically it is a protocol translator, user mode programs such as minicom or ppp will open my device, send their AT commands, and my driver will translate the data both directions.  The device attaches to the serial port.

I have written the top half, the interface between the user mode and the driver.  My question now is how to open a connection to the serial port that the device is attached to.

My first thought was to use sys_open but that is not exported, because kernel modules don't need access to files.

What is the preferred way in Linux for my module to open the serial port device such as /dev/ttyS1.

Thanks a lot

Kurt Häusler

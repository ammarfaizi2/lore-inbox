Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTIAQOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbTIAQOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:14:54 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:1249 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S263014AbTIAQOi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:14:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Bug in vsprintf.c - vsscanf()
Date: Mon, 1 Sep 2003 21:44:09 +0530
Message-ID: <52C85426D39B314381D76DDD480EEE0CFC6983@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel Mode File Operations Wrappers
Thread-Index: AcNllkQcxN2VmLptTWOPPdIb/esjfA==
From: "Ramit Bhalla" <ramit.bhalla@wipro.com>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@redhat.com>
X-OriginalArrivalTime: 01 Sep 2003 16:14:20.0098 (UTC) FILETIME=[197B8A20:01C370A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There appears to be a bug in vsprintf.c
The function vsscanf (if I'm correct) is the kernel mode equivalent of user mode sscanf.
If one tries to read a hex string using the format "%x" it returns an error if the read buffer contains any character other than 0-9.

I believe the culprit lies on line 640 of vsprintf.c

It should be "isxdigit" instead of "isdigit".

Hope I'm not missing anything here :)

Ramit.

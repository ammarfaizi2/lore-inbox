Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbVKIUf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbVKIUf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbVKIUf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:35:58 -0500
Received: from mail.networkengines.com ([12.163.137.254]:3023 "EHLO
	mail-imc.networkengines.com") by vger.kernel.org with ESMTP
	id S1161229AbVKIUf5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:35:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Reading BIOS information from a kernel driver
Date: Wed, 9 Nov 2005 15:35:30 -0500
Message-ID: <4A3725E53DCF3E4B9D5C63880C3F980055B493@mail2.networkengines.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reading BIOS information from a kernel driver
Thread-Index: AcXlbSAEKh1rVl22TdedRvA8Rx7DiQ==
From: "Steven Schveighoffer" <StevenS@NetworkEngines.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Nov 2005 20:35:45.0666 (UTC) FILETIME=[29474620:01C5E56D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to read a string that the BIOS has placed into memory.

The BIOS placed the string into memory at real-mode address F000:FA00
(i.e. physical address FFA00h).

1. Is there a linear address which always contains this address
location?  i.e. if there is a spot where I can do:

char * mystring = (char *)0xMagicAddress;

2. If not, how do I map a linear address to this physical address so I
can read it?

I'm pretty sure that the string can be read, but I would prefer to know
exactly where the string is located before looking.  For example, the
following command finds the string:

dd if=/proc/kcore bs=1024 count=3000 | grep mystring

-Steve

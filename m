Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbTKUPy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 10:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTKUPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 10:54:58 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:4508 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id S264366AbTKUPy5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 10:54:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: DIRECT IO for ext3/ext2.
Date: Fri, 21 Nov 2003 21:23:06 +0530
Message-ID: <1E27FF611EBEFB4580387FCB5BEF00F3013DEEE8@blr-ec-msg04.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DIRECT IO for ext3/ext2.
Thread-Index: AcOwR41rB3v363nNSQaYnWx3dtOVOA==
From: <dhruv.anand@wipro.com>
To: <linux-kernel@vger.kernel.org>
Cc: <akpm@zip.com.au>, <janetinc@us.ibm.com>, <akpm@zip.com.au>,
       <pbadari@us.ibm.com>, <nathans@sgi.com>
X-OriginalArrivalTime: 21 Nov 2003 15:53:06.0968 (UTC) FILETIME=[8E191180:01C3B047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am working on an application on linux-2.6 that needs to
bypass the buffer cache. In order to do so i use the direct
IO functionality. Although open to the device succeeds with
the DIRECT_IO flag, read from the device fails.

Following is the exceprt fromt he code to open and read;
--------------------------------------------------------

if ((devf = open(dumpdev, O_RDONLY | O_DIRECT, 0)) < 0) {
     fprintf(KL_ERRORFP, "Error: open failed!\n");
     ...
}

if(err = read(devf, &magic_nr, sizeof(magic_nr)) != sizeof(magic_nr)) {
     fprintf(KL_ERRORFP, "Error: read() failed!\n");
      ...
}

---------------------------------------------------------
I am returned an errno=22, indicating 'Invalid argument'

I would appreciate it, if you could knowledge me importantly about
the completeness of the 'direct IO' functionality in ext3 file-system.
Or if i am doing something wrong in usage?


Regards
Dhruv.

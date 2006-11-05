Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWKEGuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWKEGuw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWKEGuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:50:52 -0500
Received: from bgerelbas02.asiapac.hp.net ([15.219.201.135]:15579 "EHLO
	bgerelbas02.asiapac.hp.net") by vger.kernel.org with ESMTP
	id S1161015AbWKEGuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:50:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Need help in writing Layered driver in Linux
Date: Sun, 5 Nov 2006 12:20:48 +0530
Message-ID: <B57F74065657FA4F85110272279E461B016F6F19@BGEEXC07.asiapacific.cpqcorp.net>
In-Reply-To: <1162709037.28571.209.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help in writing Layered driver in Linux
Thread-Index: AccApchzuFCebc3LRhi2yWRb6HpGNAAALqnw
From: "Palakodeti, Srinivasa Rao (STSD)" <palakodetisrinivasa.rao@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2006 06:50:48.0849 (UTC) FILETIME=[BA002010:01C700A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All, 

I want to write a layered driver for a device in Linux. I am overwriting
make_request_fn in blk_dev strucure. Whenever they is an I/O my
make_request_fn is called so that I can change the buffer_head and send
to other disk by calling submit_bh in my make_request_fn as following.



		bh->b_dev = MKDEV(252,0); // I am changing to other disk
device
		atomic_set(&bh->b_count, 1);
		submit_bh(WRITE, bh);

This is not working. It is giving me kernel panic Could you help me how
should I go about it? 

My purpose is all I/O to Disk1 should to passed to Disk2. 


Regards,
Srinivas 

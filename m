Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289001AbSAVAFH>; Mon, 21 Jan 2002 19:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289027AbSAVAFD>; Mon, 21 Jan 2002 19:05:03 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:14846 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289001AbSAVAEw>; Mon, 21 Jan 2002 19:04:52 -0500
Subject: Throughput Degradation with 4GB Kernel
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFD79989B4.B63582F0-ON85256B48.00812381@raleigh.ibm.com>
From: "Partha Narayanan" <partha@us.ibm.com>
Date: Mon, 21 Jan 2002 18:04:50 -0600
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/21/2002 07:04:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some VolanoMark results that show throughput
differences for 1GB and 4GB kernel build options.

This test runs in loopback mode, with no disk activity,
so the 4GB degradation should not be related to bounce
buffers.

A time based profile did not provide any insight into
why the 4GB kernel on a 4-way degrades.  We will get a
a kernprof acg for both the 1GB and 4GB kernels.

This degradation was unexpected.
Any ideas on what may be causing this degradation ?

VolanoMark 2.1.2 10/100 loopback test,
8-way 700MHZ Pentium III,
IBM JVM 1.3. (build cx 130 -20010626)
Throughput in msg/sec


Kernel            UP          4-way       8-way
=======           =====       =====       ======
2.4.14 1GB        11024       17565       13734
2.4.14 4GB        11060       13378       13030
-----------------------------------------------


2.4.16 1GB        11064       16292       11840
2.4.16 4GB        11105       12605        9434
-----------------------------------------------


2.4.17 1GB        11005       15894       11595
2.4.17 4GB        11057       12754        9363
-----------------------------------------------





Partha Narayanan
partha@us.ibm.com


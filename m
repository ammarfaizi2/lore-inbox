Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265454AbUF2E71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265454AbUF2E71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUF2E70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:59:26 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:5929 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S265454AbUF2E7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:59:20 -0400
X-BrightmailFiltered: true
Message-Id: <5.1.0.14.2.20040629145623.03cdf008@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 29 Jun 2004 14:59:10 +1000
To: Ben Greear <greearb@candelatech.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: 2.6.7 tiobench results for 3ware 9500 system
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40E0E690.2040100@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:48 PM 29/06/2004, Ben Greear wrote:
>I am trying to build a box that can handle streaming 2Gbps to disk for
>sustained periods of time.  I benchmarked a few different file systems
>and wanted to share the results.

for large amounts of data, you should ensure that your application opens 
the open using O_DIRECT.

i have no experience with 3ware controllers, but i have no problem 
sustaining 400MB/s (4gbit/s) to a Fibre Channel-attached JBOD with an 
in-house userspace-based application which maintains its own 
userspace-based filesystem on raw partitions (/dev/sd[b-w]).
using 15K RPM disks i can sustain 400MB/s using just 6 disk spindles and 
what amounts to predominantly sequential writes.


cheers,

lincoln.


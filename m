Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWGRRa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWGRRa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGRRa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 13:30:28 -0400
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:32979 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S932325AbWGRRa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 13:30:28 -0400
Message-ID: <44BD1AB6.10009@atipa.com>
Date: Tue, 18 Jul 2006 12:30:30 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>, mpt_linux_developer@lsil.com
Subject: newer MPT speed issue on Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jul 2006 17:30:31.0674 (UTC) FILETIME=[DE81EDA0:01C6AA8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am have tested with Sles9.1sp1, Sp3, and kernel.org 2.6.17.6 and
here are some results:
		
SLES9.1sp1 (kernel only)	100-120MB/second writes  75-80MB/second reads
SLES9.0sp3			20-30MB/second writes
2.6.17.6			20-30MB/second writes   140-150MB/second reads

This is with  the LSI Logic / Symbios Logic FC929X Fibre Channel Adapter 
(rev 81)

All 3 are with a SLES9sp3 distribution and are on the same machine with 
only the kernel
being changed.   The test is a simple "dd if=/dev/zero of=/dev/dk001/two 
bs=65536 &"
with vmstat being used to determine io speed.   Bonnie++ is getting 
similar results
to what dd is generating when writing to a filesystem.

The fiber channel card is hooked to a external raid5 chassis, and it 
being accessed
though LVM.

Are there some parameters that I am missing that could speed the writes up?

The reads on the newer driver are a nice improvement, but the writes on
the newer driver are horrible in my testing.

                               Roger

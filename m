Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbUKKP2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUKKP2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKKPZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:25:54 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:27103 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S262246AbUKKPTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:19:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16787.33524.397332.953427@gargle.gargle.HOWL>
Date: Thu, 11 Nov 2004 10:19:16 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: "Siddhesh Bhadkamkar" <siddheish@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 IDE driver
In-Reply-To: <BAY2-F311s7nlT2NqFJ0002718f@hotmail.com>
References: <BAY2-F311s7nlT2NqFJ0002718f@hotmail.com>
X-Mailer: VM 7.14 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Siddhesh> we are trying to modify IDE driver as a possible workaround
Siddhesh> for an unreliable storage media.

Yuck, don't do that, just use the Linux RAID tools and mirror your
data.

Siddhesh> this driver will expose only a part of the disk to file
Siddhesh> system by reporting the disk capacity as say
Siddhesh> real_capacity/4. remaining disk will be hidden from the file
Siddhesh> system. in write operation driver will try to write the same
Siddhesh> data in all 4 parts of the same disk for redundancy. in read
Siddhesh> it will hope to find atleast one copy properly written.

Use the 'md' raid modules instead.  You can divide the disk(s) into
multiple volumes, then mirror/stripe your data across that instead.
If a disk fails, you're toast if you haven't got data on another
disk.

If it's the media that's possibly flaky, then partitioning into
multiple areas and using 'md' to RAID across partitions might help.
Performance will suck though.  

If the underlying media is flaky, then you're going to have lots and
lots of problems.

John


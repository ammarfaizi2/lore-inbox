Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTLAMkh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 07:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTLAMkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 07:40:37 -0500
Received: from sklave3.rackland.de ([213.133.101.23]:27112 "EHLO
	sklave3.rackland.de") by vger.kernel.org with ESMTP id S263014AbTLAMkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 07:40:36 -0500
From: hadmut@danisch.de
Date: Mon, 1 Dec 2003 13:40:34 +0100
To: linux-kernel@vger.kernel.org
Subject: Partitions on a loopback block device?
Message-ID: <20031201124034.GA32127@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently trying to do hard disk backups of some machines 
with different operating systems using a bootable Linux CD.

Backing up every single partition is fine, but overhead and
requires additional backup of the partition table in order
to be able to play it back. 

What I would like to do is to have a full backup with

dd if=/dev/hda of=somewhere

and to mount the partitions of this file with the loopback block
driver.

A simple approach would be to use losetup with the offset function for
every single parttion (while I'm not sure whether this works through 
the CHS geometry).

Would it be possible to have a loopback blockdevice recognize
partition tables and to provide partitions as any other block device?

Obviously, naming is not very elegant, but /dev/loopa0 would be a nice
analogon to /dev/hda0 and /dev/sda0

regards
Hadmut

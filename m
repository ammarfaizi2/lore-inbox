Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUCGLZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 06:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUCGLZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 06:25:31 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:40865 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261809AbUCGLZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 06:25:30 -0500
Subject: cryptoloop support broken in 2.6.3-ben2
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078658565.3047.4.camel@localhost>
Mime-Version: 1.0
Date: Sun, 07 Mar 2004 12:22:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi..

copying something to a cryptoloop file crashes the machine (random
crashes), this is similiar to the report I send for 2.6.0-test11... it
was working with the 2.6.0-test10-mm1 loop-* patches and IIRC with
2.6.1.

Now it is broken again, not sure whether this is due to the big
endianness of this machine.

To crash do:

dd if=/dev/zero of=/file bs=1M count=100
losetup -e blowfish /dev/loop0 /file
Password:
mkfs -t ext3 /dev/loop0
mount /dev/loop0 /mnt
cd /mnt  
dd if=/dev/zero of=bla

Soeren.


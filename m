Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTECQjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTECQjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:39:20 -0400
Received: from smtp6.uk1.bibliotech.net ([212.57.34.117]:38098 "EHLO
	smtp6.uk1.bibliotech.net") by vger.kernel.org with ESMTP
	id S263349AbTECQjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:39:19 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: ragnar sjoberg <ragnarsjoberg@postmaster.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 using root floppy: blk: request botched
Date: Sat, 03 May 2003 17:44:09 +0100
X-Postmaster: Sent from Postmaster http://www.postmaster.co.uk/, the
    world's premier web based email service, based in London, England.
X-Postmaster-Trace: Account name: ragnarsjoberg; Domain name:
    postmaster.co.uk; Local time: Sat May  3 17:44:09 2003; Local host:
    pmweb8.uk1.bibliotech.net; Remote host: 144.57.128.4; Referer site:
    www.postmaster.co.uk
X-Complaints-To: General account for reporting spam and other abuse of the
    service <Administrator@postmaster.co.uk>, IT coordinator at responsible
    organisation <Administrator@postmaster.co.uk>
X-Postmaster-Team-Photo: http://www.postmaster.co.uk/static/en/nav/credits
    .html
Message-Id: <PM.17000.1051980249@pmweb8.uk1.bibliotech.net>
Reply-To: ragnarsjoberg@postmaster.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If loading kernel 2.5.68 from boot floopy,
and changing disk when prompted, to root floppy, it starts to load the root fs from floppy but stop with:
blk: request botched

the root floppy is built (on 2.4.20 machine) using these commands:

dd if=/dev/zero of=./root.fs bs=1k count=1400
mkfs -t ext2 -N 200 -m 0 ./root.fs
mount -o loop ./root.fs ./root
cp -a $root_contents/* ./root
umount ./root
dd if=./root.fs of=/dev/fd0 bs=1k

thanks for any info on this.

Ragnar


___________________________________________________ 
What is the chemical symbol for Tin? 
Find out at postmaster.co.uk

http://www.postmaster.co.uk/cgi-bin/meme/quiz.pl?id=208

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSGMPNp>; Sat, 13 Jul 2002 11:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSGMPNo>; Sat, 13 Jul 2002 11:13:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48366 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314514AbSGMPNn>;
	Sat, 13 Jul 2002 11:13:43 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 13 Jul 2002 17:16:33 +0200 (MEST)
Message-Id: <UTC200207131516.g6DFGXr01707.aeb@smtp.cwi.nl>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: 2.5.25+ide24 oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An oops on a 2.5.25+ide24 system (with a few unrelated patches):

First cdrom_do_block_pc() invents a packet command and puts it
into rq->special.
Then cdrom_do_packet_command() wants to take it from rq->buffer,
which is NULL.
Oops.

Andries


[Apart from this oops: I have now used this kernel for many hours,
stressing various disks - the disk I/O part is solid for me.]

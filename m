Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266153AbUFUHVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUFUHVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:19:12 -0400
Received: from smtpout.ev1.net ([207.44.129.133]:51462 "EHLO smtpout.ev1.net")
	by vger.kernel.org with ESMTP id S266141AbUFUHSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:18:00 -0400
Date: Mon, 21 Jun 2004 02:16:51 -0500
From: Michael Langley <nwo@hacked.org>
To: linux-kernel@vger.kernel.org
Subject: Problem with psmouse detecting generic ImExPS/2
Message-Id: <20040621021651.4667bf43.nwo@hacked.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this after upgrading 2.6.6->2.6.7

Even after building psmouse as a module, and specifying the protocol,
all I get is an ImPS/2 Generic Wheel Mouse.

[root@purgatory root]# modprobe psmouse proto=exps
Jun 21 01:51:57 purgatory kernel: input: ImPS/2 Generic Wheel Mouse on
isa0060/serio1

My ImExPS/2 was detected correctly in <=2.6.6 and after examining the
current psmouse code, and the changes in patch-2.6.7, I can't figure out
what's breaking it.  A little help?

Kernel version: Linux version 2.6.7 (root@purgatory) (gcc version 3.3.3
(Debian 20040422)) #1 Fri Jun 18 17:20:28 CDT 2004

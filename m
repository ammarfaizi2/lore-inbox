Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTFPL0X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFPL0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:26:23 -0400
Received: from pd135.torun.sdi.tpnet.pl ([213.76.208.135]:48318 "EHLO
	athena.raptor.pl") by vger.kernel.org with ESMTP id S263749AbTFPL0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:26:22 -0400
Date: Mon, 16 Jun 2003 13:40:11 +0200 (CEST)
From: Andrzej Sosnowski <raptor@lists.raptor.pl>
X-X-Sender: raptor@athena.raptor.pl
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 oops
Message-ID: <Pine.LNX.4.44.0306161220200.19177-100000@athena.raptor.pl>
X-Info: nick: raptor; www: http://raptor.pl
X-PGP/GPG-Key: 0xB71774A2; http://raptor.pl/raptor.pgp.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: AVscanner at raptor.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Kernel makes an oops while executing the following script:

#!/bin/sh
for IP in `/usr/bin/seq 3 500`; do
  ip addr add 3ffe:80ee:c1d::$IP/48 dev eth0
  ip addr add 3ffe:80ee:c1d::a:$IP/48 dev eth0
done

Result:
kernel BUG sched.c 564!
(sorry for incomplete oops message)

Tested on:
  debian 2.4.21
  debian/redhat 2.4.21-grsec 1.9.10
  redhat 2.4.21-uv2-grsec 1.9.10

This script with 2.4.20 working fine.

-- 
____________________________________________________________________
andrzej sosnowski * raptor@raptor.pl * http://raptor.pl * 0xB71774A2








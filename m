Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbVITFHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVITFHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbVITFHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:07:53 -0400
Received: from ms-smtp-03-lbl.southeast.rr.com ([24.25.9.102]:34531 "EHLO
	ms-smtp-03-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932726AbVITFHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:07:52 -0400
Message-Id: <200509200507.j8K57kY6006302@ms-smtp-03-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Unknown symbol in crc32c in 2.6.13.1
Date: Tue, 20 Sep 2005 01:07:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcW9oRbwhkLD8WioQCOPSlN1bnvowA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  I see this error repeatedly.  Running Debian latest stable branch w/
custom 2.6.13.1 kernel.  I've got the racoon package installed and I'm
running IPSec between two such gateways.  On both ends, when I start Racoon
for my IPSec link I always get the following error:

###################################################
firewall:~# /etc/init.d/racoon restart
Stopping IKE (ISAKMP/Oakley) server: racoon.
Flushing SAD and SPD...
SAD and SPD flushed.
Unloading IPSEC/crypto modules...
IPSEC/crypto modules unloaded.
Loading IPSEC/crypto modules...

insmod: error inserting
'/lib/modules/2.6.13.1-firewall/kernel/crypto/crc32c.ko': -1 Unknown symbol
in module


IPSEC/crypto modules loaded.
Starting IKE (ISAKMP/Oakley) server: racoon.
Flushing SAD and SPD...
SAD and SPD flushed.
Loading SAD and SPD...
SAD and SPD loaded.
Configuring racoon...done.
###################################################

It doesn't seem to be fatal, but I figured I'd report it since it seems to
be continuous.  Syslog gives only the following:

Sep 20 00:58:53 localhost kernel: crc32c: Unknown symbol crc32c_le

I hope this problem isn't considered too trivial to report...sorry if I'm
wasting your time with it.

-
Matt



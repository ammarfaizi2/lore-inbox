Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVAJBXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVAJBXd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVAJBXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:23:33 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:24771 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S262035AbVAJBXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:23:32 -0500
Date: Mon, 10 Jan 2005 03:23:30 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: vfat unlink latency 54.6ms for 128MB files
Message-ID: <20050110012330.GA10846@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering, when I remove a 128MB file on vfat partition
(usb-storage, memcard reader), it causes 54.6ms latency
in rtc_latencytest...  latency seems to increase linearly
as the filesize grows.  I calculated 1s would be reached with
2344MB file but I didn't bother trying that yet.
Are there any possible fixes for fat fs so
that it doesn't disable interrupts for that long a time?

When I use loop device (the file on reiserfs), I get 45.9ms latency,
so this is not usb's fault. 

These with Linux-2.6.10-ac8 on UP, PPro+, no preempt.
http://safari.iki.fi/vfat-unlink/

-- 


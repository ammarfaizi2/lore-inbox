Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUGaVC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUGaVC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 17:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUGaVC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 17:02:58 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:55738 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S263040AbUGaVC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 17:02:58 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Sat, 31 Jul 2004 23:03:14 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: linux-kernel@vger.kernel.org
Subject: problem with new swsusp
Message-ID: <20040731210314.GA3436@linux.nu>
Reply-To: erik@rigtorp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The merged swsusp in 2.6.7-rc2-mm1 doesn't turn off the hard drive before
before shutdown. This results in a rather abrupt sound during suspend on my
IBM Thinkpad X31. I tried adding a call to device_shutdown(); in disk.c
after line 52, this seems to fix the problem.

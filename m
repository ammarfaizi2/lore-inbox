Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVD1Qpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVD1Qpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVD1Qpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:45:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3024 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262167AbVD1Qpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:45:31 -0400
Subject: IDE problems with rmmod ide-cd
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114706653.18330.212.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 17:44:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you rmmod ide-cd in 2.6.12rc3 it issues a cache flush command to the
drive. Thankfully the bogus command this time is an ATAPI cache flush
not an ATA one so won't do any major harm but its still wrong as the
device is not a writer or packet mode capable (its a random DVD reader
holding a music CD)

Alan


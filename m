Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbUKHSHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUKHSHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbUKHRFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:05:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17098 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261920AbUKHQRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:17:00 -0500
Subject: Re: [BUG] IDE, VIA VT8235, md5sum Input/Output error after CD burn.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ali Akcaagac <aliakc@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099790667.814.22.camel@localhost>
References: <1099790667.814.22.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099926842.5630.137.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 15:14:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-07 at 01:24, Ali Akcaagac wrote:
> anymore. Before that named version or even on 2.4.x it works like a
> charm. When burning a CDRW you can md5sum the ISO and the device (as in
> my case /dev/hdc) and you get the values spit out correctly and
> matching.

Known problem. Use ide-scsi not ide-cd, ide-cd is broken when reading
near the end sectors of CD-R or CD-RW media

(Its been in bugs.kernel.org for a while)


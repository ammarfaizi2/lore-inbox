Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRKSJtF>; Mon, 19 Nov 2001 04:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276761AbRKSJsz>; Mon, 19 Nov 2001 04:48:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50443 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276477AbRKSJsf>; Mon, 19 Nov 2001 04:48:35 -0500
Subject: Re: Important, Memory padding in kernel using 1byte
To: davidchow@rcn.com.hk (David Chow)
Date: Mon, 19 Nov 2001 09:56:24 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1006160395.1198.0.camel@star9.planet.rcn.com.hk> from "David Chow" at Nov 19, 2001 04:59:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165lA8-000613-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 32-bit (4 bytes) on IA32's. This cause lots of trouble when doing file
> system developments where a couple of data structures are not multiple
> of 4 bytes. This cause lots of errors, I think this should be notified

Its up to the fs developer to handle such data structures. You should also
be aware that misaligned references may fault and crash the kernel in some
cases on non x86 platforms


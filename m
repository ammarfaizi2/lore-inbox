Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVFUMhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVFUMhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFUMgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:36:21 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:2980 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261299AbVFUMaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:30:30 -0400
Subject: Re: struct iphdr in include/linux/ip.h (probably bug in headerfile)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: k8 s <uint32@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <699a19ea05062100157c17c09c@mail.gmail.com>
References: <699a19ea05062100157c17c09c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119356872.3325.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 13:27:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 08:15, k8 s wrote:
> Hello,
> 
> The following definition in linux/include/ip.h is creating problems.
> 
> How does Endianness affect BIT ORDER 
> IT affetc only  BYTE ORDER

Bitfield order is a compiler property. Byte order is usually a processor
property and the two are not exactly connected.

A compiler given two bit fields can pack them from the high bit or from
the low bit and may do different things depending on the platform. The
defines tell the kernel whether the compiler packs bitfields into the
low bits first or the high bits first.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268825AbUHLWPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268825AbUHLWPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268826AbUHLWPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:15:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:12247 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268825AbUHLWPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:15:04 -0400
Subject: Re: Linux kernel file offset pointer races
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812223057.CF9.0@argo.troja.mff.cuni.cz>
References: <20040812223057.CF9.0@argo.troja.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092345143.22458.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 22:12:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 22:38, Pavel Kankovsky wrote:
> In this scenario, the 1st and 3rd pages read by read() contain the old
> data (before write()) but the 2nd page contains the new data (after
> write()). This is absurd.

Why ?

> BTW: What about writev() (esp. with O_APPEND)? It appears Linux
> implementation makes it possible to interleave parts of writev() with
> other writes.

If that can occur with O_APPEND it might be a bug. SuS does make some
real guarantees about what O_APPEND means.

> Moreover, there appears to be a race condition between locks_verify_area()
> and the actual I/O operation(s).

Details ?



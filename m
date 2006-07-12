Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWGLLkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWGLLkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGLLkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:40:41 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41378 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751314AbWGLLkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:40:40 -0400
Subject: Re: Problems with oom killer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell Stuart <russell-lkml@stuart.id.au>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1152663312.4267.20.camel@ras.pc.brisbane.lube>
References: <1152663312.4267.20.camel@ras.pc.brisbane.lube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Jul 2006 12:57:51 +0100
Message-Id: <1152705471.22943.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 10:15 +1000, ysgrifennodd Russell Stuart:
> It is running the Debian stable kernel (2.6.8.1) with
> cfq on a dual core machine.  Although it shouldn't be,

2.6.8 certainly had problems in some cases where there was a lot of I/O
going on and it would out-of-memory when it should have been trying
harder to dump all the dirty pages to disk.

> Any clues would be appreciated.

Not really a fix in itself but see what happens if "sync" gets called
every 30 seconds or so during the backup that triggers the problem.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVAGDAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVAGDAs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAGC7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 21:59:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57023 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261195AbVAGC7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 21:59:42 -0500
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Tim_T_Murphy@Dell.com, rmk+lkml@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DDDB47.8050008@microgate.com>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D32@ausx2kmps304.aus.amer.dell.com>
	 <1105052674.24187.288.camel@localhost.localdomain>
	 <41DDDB47.8050008@microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105062326.17176.313.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 01:54:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 00:43, Paul Fulghum wrote:
> IIRC that guarantees a deadlock on SMP due to the
> generic serial layer trying to grab a spinlock
> that is already held. (Which prompted the original
> bug report by Tim several months ago)

I fixed the tty locking issues with that. If there are any left they
should be solely in the serial generic code and I've no idea there


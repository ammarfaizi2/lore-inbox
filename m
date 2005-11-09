Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbVKIR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbVKIR0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbVKIR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:26:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:15084 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030580AbVKIR0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:26:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Aritz Bastida <aritzbastida@gmail.com>
Subject: Re: Stopping Kernel Threads at module unload time
Date: Wed, 9 Nov 2005 18:27:48 +0100
User-Agent: KMail/1.7.2
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
References: <7d40d7190511090749j3de0e473x@mail.gmail.com> <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com> <7d40d7190511090856x24fd68f5g@mail.gmail.com>
In-Reply-To: <7d40d7190511090856x24fd68f5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511091827.49144.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Middeweken 09 November 2005 17:56, Aritz Bastida wrote:
> Now, if I call kthread_stop() in module unload time, does that code
> run in user process context just like system calls do? That is
> important, because if it cannot sleep, it would deadlock.

Yes, it runs in the context of the delete_module system call.
I think it's more likely that you're not returning from your
thread loop.

Please post a URL for your module source code so we can see
what goes wrong there.

	Arnd <><

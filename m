Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTDVI2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTDVI2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:28:48 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.28]:9394 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263016AbTDVI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:28:47 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Heiko.Rabe@InVision.de
Subject: Re: inconsistent usage of
Date: Tue, 22 Apr 2003 10:40:45 +0200
User-Agent: KMail/1.5.1
References: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
In-Reply-To: <OF07767E6D.29E660DD-ONC1256D10.002B8A2D@invision.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304221040.45480.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> void foo()
> {
>      unsigned long  local_flags;
>      spin_lock_irqsave (&qtlock, local_flags);
>      spin_lock_irqsave (&qtlock, local_flags);
> }
>
> Calling the function foo() works proper in none SMP kernels. I assume, the
> spinlocks internaly will be initialized as
> recursive semaphore as default. So it is possible to aquire it more than
> once by the same thread.

No.  If you acquire it twice then you die.  The above code is wrong.
Where did you find it?

All the best,

Duncan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVCODu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVCODu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVCODu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:50:29 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:64845 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262226AbVCODuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:50:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TXiJuvOfltP+1MRCYNs7RjSTTBG7i68omKlcUcdkeJgaMhzLess1fkzp26OZPUL8CzTofUUg/R1xzaui0XDD0+G9fcJTSRX3TPBLcKC1RoaGaR8W4nAQoqHB7CS6dHHJUCMcwaqsoQGCUCiQdAxmAGzMIYAG4pLb3cUplKJqtfg=
Message-ID: <9e47339105031419501ccd650c@mail.gmail.com>
Date: Mon, 14 Mar 2005 22:50:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <16950.23262.895279.635262@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	 <9e473391050312075548fb0f29@mail.gmail.com>
	 <16948.56475.116221.135256@wombat.chubb.wattle.id.au>
	 <9e47339105031317193c28cbcf@mail.gmail.com>
	 <16948.60419.257853.470644@wombat.chubb.wattle.id.au>
	 <9e47339105031419195bae4e11@mail.gmail.com>
	 <16950.23262.895279.635262@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 14:47:42 +1100, Peter Chubb
<peterc@gelato.unsw.edu.au> wrote:
> What I really want to do is deprivilege the driver code as much as
> possible.  Whatever a driver does, the rest of the system should keep
> going.  That way malicious or buggy drivers can only affect the
> processes that are trying to use the device they manage.  Moreover, it
> should be possible to kill -9 a driver, then restart it, without the
> rest of the system noticing more than a hiccup.  To do this,
> step one is to run the driver in user space, so that it's subject to
> the same resource management control as any other process.  Step two,
> which is a lot harder, is to connect the driver back into the kernel
> so that it can be shared.  Tun/Tap can be used for network devices,
> but it's really too slow -- you need zero-copy and shared notification.

Have you considered running the drivers in a domain under Xen?

> 
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*
> 


-- 
Jon Smirl
jonsmirl@gmail.com

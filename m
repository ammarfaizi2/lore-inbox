Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUJOXUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUJOXUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUJOXUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:20:06 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:6064 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267362AbUJOXUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:20:00 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=FY+GcEF+M7QptIRgmGKALXPZ2WGXUfvYwjM6J6mYVl8XuWGIVfXltw1+ZZtH2rYmo/msBO0yA2UC/l3rrIStRsE9NBsMuZvQ0L7bAtZmb+ZYirBNJk8D/HEKWreXV2GSjW532uUZCsYjVXzXGhLuyuCnFsuoMHsdvvXynqNHGu4
Message-ID: <9e47339104101516206c8597d3@mail.gmail.com>
Date: Fri, 15 Oct 2004 19:20:00 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Cc: Kendall Bennett <kendallb@scitechsoft.com>, linux-kernel@vger.kernel.org,
       penguinppc-team@lists.penguinppc.org,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <200410160551.40635.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <416E6ADC.3007.294DF20D@localhost>
	 <416FB624.17156.1D23C23@localhost>
	 <200410160551.40635.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2004 05:51:38 +0800, Antonino A. Daplas
<adaplas@hotpop.com> wrote:
> Yes, that is the downside to a userspace solution. How bad will that be?
> Note that Jon Smirl is proposing a temporary console driver for early
> boot messages until the primary console driver activates.

Does anyone know exactly how big the window is from when a compiled in
console activates until one that relies on initramfs loads? I don't
think it is very big given that a lot of the early printk's are queued
before they are displayed.

Other than embedded systems, are there machines that have no BIOS/PROM
display at all and rely entirely on a bootable kernel for display? If
so, how do machines like this put up a message that they can't find
the kernel? How do you get hardware diagnostic messages from them?

In the case of something like a Mac you would want to keep the display
blank until the early user space code initializes the display in
graphics mode. Only if you get a fatal error before this would you
dump the info using the Open Firmware display. Same strategy would
apply to x86.

-- 
Jon Smirl
jonsmirl@gmail.com

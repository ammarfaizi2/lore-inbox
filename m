Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVKFXdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVKFXdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVKFXdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:33:04 -0500
Received: from [81.2.110.250] ([81.2.110.250]:52697 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751277AbVKFXdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:33:02 -0500
Subject: Re: Fwd: [RFC] IRQ type flags
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051106224225.GC6274@flint.arm.linux.org.uk>
References: <20051106084012.GB25134@flint.arm.linux.org.uk>
	 <1131316897.1212.61.camel@localhost.localdomain>
	 <20051106221643.GB6274@flint.arm.linux.org.uk>
	 <1131317998.1212.63.camel@localhost.localdomain>
	 <20051106224225.GC6274@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Nov 2005 00:03:22 +0000
Message-Id: <1131321802.1212.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-06 at 22:42 +0000, Russell King wrote:
> We could do as you suggest, but my concern would be adding extra
> complexity to drivers, causing them to do something like:
> 
> 	ret = request_irq(..., SA_TRIGGER_HIGH, ...);
> 	if (ret == -E<whatever>)
> 		ret = request_irq(..., SA_TRIGGER_RISING, ...);
> 
> The alternative is:
> 
> 	ret = request_irq(..., SA_TRIGGER_HIGH | SA_TRIGGER_RISING, ...);

I was thinking that specifying neither would imply 'don't care' or
'system default'. That would mean existing drivers just worked and
driver authors who didnt care need take no specific action.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWJMAji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWJMAji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWJMAji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:39:38 -0400
Received: from twin.jikos.cz ([213.151.79.26]:44257 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751392AbWJMAjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:39:37 -0400
Date: Fri, 13 Oct 2006 02:39:26 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix parport_serial_pci_resume() ignoring return value
 from pci_enable_device()
In-Reply-To: <20061012235820.GC24658@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610130229480.29022@twin.jikos.cz>
References: <Pine.LNX.4.64.0610130139510.29022@twin.jikos.cz>
 <20061012235820.GC24658@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Russell King wrote:

> I suspect all these kind of patches are introducing additional problems.
> This one certainly is.  Who's auditing all these patches?  I mean _properly_
> auditing them rather than just saying "that's a good idea"?

For the fm801 gameport case it is fine - it's just one more check in the 
_probe() function, performing the same error path as other cases do.

ALSA case has already been solved by calling snd_card_disconnect() on 
error path.

But I agree that sk98lin and parport_serial_pci patches are likely broken.

Thanks,

-- 
Jiri Kosina

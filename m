Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289077AbSA1BCt>; Sun, 27 Jan 2002 20:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289080AbSA1BCj>; Sun, 27 Jan 2002 20:02:39 -0500
Received: from zero.tech9.net ([209.61.188.187]:55300 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289077AbSA1BC0>;
	Sun, 27 Jan 2002 20:02:26 -0500
Subject: Re: [PATCH] Fix NR_IRQS when no IO apic
From: Robert Love <rml@tech9.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C549E5E.4ACA093D@mandrakesoft.com>
In-Reply-To: <3C549AEC.D79A95FC@didntduck.org> 
	<3C549E5E.4ACA093D@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 27 Jan 2002 20:07:42 -0500
Message-Id: <1012180063.808.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-27 at 19:42, Jeff Garzik wrote:

> What about when ioapic is configured but not present?

Then we are back where we started?  Which, unless I am missing
something, is just a waste of memory?

I see this as a no-change if CONFIG_X86_IO_APIC is set, but a proper
setting of NR_IRQS (which doesn't hurt anything but make our
arrays/loops/etc off if not set) for the case of non-IOAPIC.

	Robert Love


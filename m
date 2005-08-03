Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVHCKjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVHCKjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVHCKjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:39:02 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58858 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262221AbVHCKiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:38:14 -0400
Subject: [Question] arch-independent way to differentiate between user and
	kernel
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
	 <1122931238.4623.17.camel@dhcp153.mvista.com>
	 <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 06:37:52 -0400
Message-Id: <1123065472.1590.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm dealing with a problem where I want to know from __do_IRQ in
kernel/irq/handle.c if the interrupt occurred while the process was in
user space or kernel space.  But the trick here is that it must work on
all architectures.

Does anyone know of some way that that function can tell if it had
interrupted the kernel or user space?  I know of serveral arch-dependent
ways, but that's not acceptable right now.

Thanks,

-- Steve



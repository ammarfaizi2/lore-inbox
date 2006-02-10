Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWBJUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWBJUWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 15:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWBJUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 15:22:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751375AbWBJUWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 15:22:10 -0500
Date: Fri, 10 Feb 2006 12:21:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at
 drivers/ieee1394/ohci1394.c:235/get_phy_reg()
Message-Id: <20060210122131.4b98cfb4.akpm@osdl.org>
In-Reply-To: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()

That's a -mm-only warning telling you that get_phy_reg() is doing a
one-millisecond-or-more busywait while local interrupts are disabled.

That's the sort of thing which makes audio developers pursue 1394 developers
with sharp sticks.


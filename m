Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946170AbWJaXyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946170AbWJaXyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946171AbWJaXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:54:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946170AbWJaXyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:54:53 -0500
Date: Tue, 31 Oct 2006 15:54:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH update5] drivers: add LCD support
Message-Id: <20061031155445.02f1aa6b.akpm@osdl.org>
In-Reply-To: <20061101003748.434a83f4.maxextreme@gmail.com>
References: <20061101003748.434a83f4.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 00:37:48 +0000
Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:

> Andrew, here it is the fifth update for the drivers-add-lcd-support.

It does queue_delayed_work(), but forgot to do cancel_delayed_work().  If
the timer is still pending after module unload, deadly things will happen.

There's a lot of "if(" in there.  Usual kernel style is "if (".


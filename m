Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbUK1IBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUK1IBa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 03:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUK1IBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 03:01:30 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:17881 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261407AbUK1IB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 03:01:27 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: John Levon <levon@movementarian.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041127233952.GA5891@compsoc.man.ac.uk>
References: <1101565560.9988.20.camel@localhost>
	 <20041127233952.GA5891@compsoc.man.ac.uk>
Date: Sun, 28 Nov 2004 10:00:22 +0200
Message-Id: <1101628822.9996.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 04:26:00PM +0200, Pekka Enberg wrote:
> > This patch adds comments for kfree() and vfree() stating that both accept
> > NULL pointers.  I audited vfree() callers and there seems to be lots of
> > confusion over this in the kernel.

On Sat, 2004-11-27 at 23:39 +0000, John Levon wrote:
> Erm, are you sure about this? Somebody had to patch OProfile because
> vfree() didn't like NULL value being passed in. When did this change?

Yes, I am sure. vfree() calls __vunmap() which returns immediately if
the passed pointer is NULL. I don't know when this changed.

		Pekka


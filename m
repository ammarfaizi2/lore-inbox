Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTIVB3A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 21:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbTIVB3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 21:29:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262719AbTIVB27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 21:28:59 -0400
Date: Sun, 21 Sep 2003 18:16:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Harald Welte <laforge@netfilter.org>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix ipt_REJECT when used in OUTPUT
Message-Id: <20030921181611.4e48af79.davem@redhat.com>
In-Reply-To: <20030921144013.GA22223@sunbeam.de.gnumonks.org>
References: <20030921144013.GA22223@sunbeam.de.gnumonks.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003 16:40:13 +0200
Harald Welte <laforge@netfilter.org> wrote:

> Some people use REJECT in the OUTPUT chain (rejecting locally generated
> packets).  This didn't work anymore starting with some fixes we did in 2.4.22. 
> A dst_entry for a local source doesn't contain pmtu information - and
> thus the newly-created packet would instantly be dropped again.

Applied to 2.4.x, thanks Harald.

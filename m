Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUGDTVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUGDTVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 15:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUGDTVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 15:21:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31207 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265649AbUGDTVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 15:21:34 -0400
Date: Sun, 4 Jul 2004 20:21:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>
Subject: Re: force O_LARGEFILE in sys_swapon() and sys_swapoff()
In-Reply-To: <20040704064440.GZ21066@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0407042010450.5234-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004, William Lee Irwin III wrote:
> 
> For 32-bit, one quickly discovers that swapon() is not given an fd
> already opened with O_LARGEFILE to act upon and the forcing of
> O_LARGEFILE for 64-bit is irrelevant, as the system call's argument is
> a path. So this patch manually forces it for swapon() and swapoff().

This one looks good, thanks.  I'm not so sure of your more general
patch to open, others know better on that.

I doubt huge amounts of swap work at all well when used, but you're
really concerned with commit at present: of course it was silly not
to have used O_LARGEFILE here.

Hugh


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVAHW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVAHW46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAHWxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:53:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29125 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261270AbVAHWxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:53:33 -0500
Subject: Re: [PATCH] A new entry for /proc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mauricio Lin <mauriciolin@gmail.com>,
       William Irwin <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105215103.10519.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 08 Jan 2005 21:47:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-08 at 20:20, Hugh Dickins wrote:
> Seems to have no locking: needs to down_read mmap_sem to guard vmas.
> Does it need page_table_lock?  I think not (and proc_pid_statm didn't).

The mmap_sem is insufficient during an exec - something that the
sys_uselib changes noted. It would work in -ac but thats a property of
how I fixed it rather than how Linus fixed it for the base kernel.


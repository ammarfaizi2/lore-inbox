Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUIEWeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUIEWeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267306AbUIEWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:34:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:35793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267304AbUIEWen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:34:43 -0400
Date: Sun, 5 Sep 2004 15:32:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-Id: <20040905153238.393c76a0.akpm@osdl.org>
In-Reply-To: <200409051659.10585.norberto+linux-kernel@bensa.ath.cx>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<20040903092721.6e9ec255.akpm@osdl.org>
	<200409031420.44018.norberto+linux-kernel@bensa.ath.cx>
	<200409051659.10585.norberto+linux-kernel@bensa.ath.cx>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Plese do not edit To: or Cc: lines.  Just do reply-to-all when working with
kernel developers.

Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
>
>  Norberto Bensa wrote:
>  > Ok, this is the output. I really hope it's usefull.
>  >
>  > 746>] default_wake_function+0x0/0x12
>  >  [<c0111746>] default_wake_function+0x0/0x12
>  >  [<c0111828>] complete+0x1a/0x24
> 
>  [SNIPPED]
> 
>  No words has been said about this issue. Do you need more info to track this 
>  problem? Attached my .config file in case it is needed.

It seems to be a bug related to O_SYNC writes on XFS.  Apparently an O_SYNC
write deadlocks immediately.  I'll take a look later, see where the bug was
introduced.


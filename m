Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbTHZP5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbTHZP5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:57:47 -0400
Received: from mail3-126.ewetel.de ([212.6.122.126]:26289 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S261461AbTHZP5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:57:43 -0400
Date: Tue, 26 Aug 2003 17:57:19 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <sct@redhat.com>, <akpm@osdl.org>
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164 
In-Reply-To: <Pine.LNX.4.44.0308261659340.4274-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0308261754390.950-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Pascal Schmidt wrote:

> Yes. Running fsx directly on my ext3 /home partition gets me the
> BUG within a few seconds, with the exact same backtrace as below.
> There don't seem to be any jbd changes from -rc1 to final 2.4.22,
> so I assume the problem exists in 2.4.22 as well.

I've just updated to 2.4.22-rc3 (since bkcvs doesn't seem to have
final 2.4.22 yet). There, the BUG is not triggered. Instead I get
tons of these:

Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 2472965)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 2472966)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 2472967)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 2472952)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 2472954)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 2472955)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 71346)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 66050)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 66050)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 66049)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 66050)

These messages pile up as long as I run fsx.

Again, this is on an ext3 partition mounted with data=journal.

-- 
Ciao,
Pascal


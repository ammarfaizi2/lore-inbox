Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUDFRzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbUDFRzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:55:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:38040 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263927AbUDFRzI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:55:08 -0400
Date: Tue, 6 Apr 2004 18:55:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: PTS alocation problem with 2.6.4/2.6.5
Message-ID: <20040406175501.GA27672@mail.shareable.org>
References: <200404052253.i35Mr6k6011170@green.mif.pg.gda.pl> <20040405165957.5f8ab8dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405165957.5f8ab8dc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> You need a glibc upgrade - we broke things for really old glibc's.  We're
> (slowly) working on fixing it up.

Looking at patch-2.6.4, there are plenty of minor changes to the pty
code but nothing that looks like it would break userspace except for
_very_ old glibcs that don't know about /dev/pts at all and just used
the legacy ones.

I have some _non-glibc_ pty code that I wish to keep working.  Can you
briefly explain how it breaks with moderately old glibcs such as the
glibc-2.3.3 that's said to be inadequate, and therefore what interface
change is needed in non-glibc code?

Thanks,
-- Jamie

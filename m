Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbUDEX5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDEX5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:57:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:12235 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263542AbUDEX5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:57:46 -0400
Date: Mon, 5 Apr 2004 16:59:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTS alocation problem with 2.6.4/2.6.5
Message-Id: <20040405165957.5f8ab8dc.akpm@osdl.org>
In-Reply-To: <200404052253.i35Mr6k6011170@green.mif.pg.gda.pl>
References: <200404052253.i35Mr6k6011170@green.mif.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl> wrote:
>
> I noticed serious problem with PTS alocation on kernels 2.6.4 and 2.6.5:
> It seems that once alocated /dev/pts entries are never reused, leading to
> pty alocation errors. The testing system is fully compiled with kernel 2.2.x
> headers (including glibc), but informations from my coleagues using systems
> compiled on 2.4/2.6 headers seems to behave similarily.
> The testcase and used kernel configuration are shown below.
> Kernel 2.6.3 does not have this problem.
> Is it bug or feature (and I am doing sth wrong) ?

You need a glibc upgrade - we broke things for really old glibc's.  We're
(slowly) working on fixing it up.


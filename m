Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbTF3PtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTF3PtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:49:04 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:61447 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264985AbTF3PtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:49:00 -0400
Date: Mon, 30 Jun 2003 18:03:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: margitsw@t-online.de (Margit Schubert-While)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 compile warnings
Message-ID: <20030630160319.GA15506@win.tue.nl>
References: <5.1.0.14.2.20030630170916.00afd930@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030630170916.00afd930@pop.t-online.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 05:13:05PM +0200, Margit Schubert-While wrote:
> 2.5.73 + latest cset
> GCC 3.3
> 
> drivers/char/vt_ioctl.c: In function `do_kdsk_ioctl':
> drivers/char/vt_ioctl.c:85: warning: comparison is always false due to 
> limited range of data type
> drivers/char/vt_ioctl.c:85: warning: comparison is always false due to 
> limited range of data type
> drivers/char/vt_ioctl.c: In function `do_kdgkb_ioctl':
> drivers/char/vt_ioctl.c:211: warning: comparison is always false due to 
> limited range of data type
> 
> drivers/char/keyboard.c: In function `k_fn':
> drivers/char/keyboard.c:665: warning: comparison is always true due to 
> limited range of data type

These are checks of the "cannot happen" type, where "cannot happen"
can be seen by the compiler, so that it can optimize the tests away.

As it is now, correctness of the code can be seen locally.
If the tests are removed, a human reader must look up the values
of these constants to conclude that the code is correct.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUFXMvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUFXMvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 08:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUFXMu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:50:59 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:15329 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264411AbUFXMu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:50:58 -0400
Date: Thu, 24 Jun 2004 05:50:53 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jason Mancini <xorbe@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
Message-ID: <20040624125053.GA14561@taniwha.stupidest.org>
References: <1088073870.17691.8.camel@xorbe.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088073870.17691.8.camel@xorbe.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 03:44:30AM -0700, Jason Mancini wrote:

> +       if (inode->i_size < 0) {
> +         inode->i_size &= 0x0FFFFFFFF;
> +       }

>From memory (this was a long time ago) this was done because there
were ISO images out there with crap in the upper bits.

If that is that case and they still cause problems, we might want to
be smarter about this and generate mask depending on how large the
entire fs is or use a mount option.


  --cw

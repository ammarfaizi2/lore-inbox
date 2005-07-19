Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVGSQQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVGSQQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVGSQQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:16:33 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:53376 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261485AbVGSQQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:16:33 -0400
X-ORBL: [63.202.173.158]
Date: Tue, 19 Jul 2005 09:16:24 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050719161623.GA11771@taniwha.stupidest.org>
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DCC7AA.2020506@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 11:28:10AM +0200, Jan Blunck wrote:

> I'm using the i_size of directories in my patches.  When reading
> from a union directory, I'm using the i_size to seek to the right
> offset in the union stack.

Ick.  That'a a bit of a hack.

> Therefore I need values of dirent->d_off which are smaller than the
> i_size of the directory.

Hence the value of 20 I guess --- assuming nothing will stack this
high?

> Altogether, it doesn't make sense to me to seek to an offset which
> is greater than the i_size and let the dirent read succeed.

I personally would prefer that to be honest or some other way that
doesn't change i_size.

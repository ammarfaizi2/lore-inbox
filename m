Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVJaOPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVJaOPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVJaOPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:15:47 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:14 "EHLO mail.parknet.co.jp")
	by vger.kernel.org with ESMTP id S932435AbVJaOPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:15:46 -0500
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/fat - fix sparse warning
References: <20051031113639.GA30667@home.fluff.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 31 Oct 2005 23:15:34 +0900
In-Reply-To: <20051031113639.GA30667@home.fluff.org> (Ben Dooks's message of "Mon, 31 Oct 2005 11:36:39 +0000")
Message-ID: <87zmophiwp.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben-linux@fluff.org> writes:

> move fat_cache_init/fat_cache_destroy to a common
> header file in fs/fat so that inode.c and cache.c
> see the same definition, and to stop warnings
> from sparse about undeclared functions

The fs/fat/* has many internal functions, it is in
include/linux/msdos_fs.h.  Please move those internal functions to one
internal header (probably fs/fat/fat.h?).

This seems be just for sparse, please do real cleanup instead.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

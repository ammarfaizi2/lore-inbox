Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265842AbUALC1o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 21:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUALC1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 21:27:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:24010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265842AbUALC1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 21:27:43 -0500
Date: Sun, 11 Jan 2004 18:27:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ciaby <ciaby@autistici.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmail slowdown on 2.6.* +reiserFS (v3)
Message-Id: <20040111182739.0686fbee.akpm@osdl.org>
In-Reply-To: <200401112109.22027.ciaby@autistici.org>
References: <200401112109.22027.ciaby@autistici.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ciaby <ciaby@autistici.org> wrote:
>
> I all!
> I've recently upgraded from 2.4 to 2.6 and I've noticed a strange thing:
> on the 2.4 kernel, kmail run decently (i've an old k6-200).
> On the 2.6 kernel, kmail slowdown and take a very long time to read a mailbox.
> I think something changed in the reiserFS during this time...
> I'm not the only experiencing this problem, read this:
> http://kerneltrap.org/node/view/1844

A buglet in kmail was tripped up by some optimisations which went into
reiserfs.

Upgrading kmail should fix it up.  Or mount the reiserfs filesystems with
the `nolargeio=1' mount option.


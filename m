Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbTK3EnX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 23:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTK3EnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 23:43:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23431 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264604AbTK3EnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 23:43:22 -0500
Date: Sat, 29 Nov 2003 20:42:53 -0800
From: "David S. Miller" <davem@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: tore@linpro.no, linux-kernel@vger.kernel.org
Subject: Re: [BUG] scheduling while atomic when lseek()ing in /proc/net/tcp
Message-Id: <20031129204253.52158f11.davem@redhat.com>
In-Reply-To: <87n0ag2z95.fsf@devron.myhome.or.jp>
References: <1069974335.14367.17.camel@echo.linpro.no>
	<87n0ag2z95.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Nov 2003 02:12:38 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> This seems to need initialization of st->state in tcp_seq_start().
> tcp_seq_stop() is run with previous st->state, so it call the unneeded
> unlock etc.

Patch applied, arigato Hirofumi-san.

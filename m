Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbTFVS6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbTFVS6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:58:53 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32283 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265512AbTFVS6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:58:51 -0400
Date: Sun, 22 Jun 2003 12:13:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-Id: <20030622121323.1abdd079.akpm@digeo.com>
In-Reply-To: <bd4u7s$jkp$1@tangens.hometree.net>
References: <20030621125111.0bb3dc1c.akpm@digeo.com>
	<20030622103251.158691c3.akpm@digeo.com>
	<bd4u7s$jkp$1@tangens.hometree.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 19:12:56.0859 (UTC) FILETIME=[49D73EB0:01C338F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" <hps@intermeta.de> wrote:
>
>  Your problem is not the compiler but the build tool / system which
>  forces you to recompile all of your kernel if you change only small
>  parts.

No, the build system is OK.  And ccache nicely fixes up any mistakes which
the build system makes, and distcc speeds things up by 2x to 3x.

None of that gets around the fact that code needs to be tested with various
combinations of CONFIG_SMP, CONFIG_PREEMPT, different subarchitectures,
spinlock debugging, etc, etc.  If the compiler is slow people don't bother
doing this and the code breaks.

Cause and effect.

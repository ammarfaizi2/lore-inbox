Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272988AbTHKTLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272975AbTHKTKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:10:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:21912 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272824AbTHKTJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:09:48 -0400
Date: Mon, 11 Aug 2003 11:55:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: willy@w.ods.org, chip@pobox.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-Id: <20030811115547.38b78b8e.akpm@osdl.org>
In-Reply-To: <1060607398.948.213.camel@cube>
References: <1060488233.780.65.camel@cube>
	<20030810072945.GA14038@alpha.home.local>
	<20030811012337.GI24349@perlsupport.com>
	<20030811020957.GE10446@mail.jlokier.co.uk>
	<20030811023912.GJ24349@perlsupport.com>
	<20030811053059.GB28640@alpha.home.local>
	<20030811054209.GN10446@mail.jlokier.co.uk>
	<1060607398.948.213.camel@cube>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sourceforge.net> wrote:
>
> -#define likely(x)	__builtin_expect((x),1)
> -#define unlikely(x)	__builtin_expect((x),0)
> +#define likely(x)	__builtin_expect(!!(x),1)
> +#define unlikely(x)	__builtin_expect(!!(x),0)

Odd.  I thought we fixed that ages ago.

Being a simple soul, I prefer __builtin_expect((x) != 0, 1).

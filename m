Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270997AbTHFTQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270995AbTHFTQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:16:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:27814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270997AbTHFTQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:16:20 -0400
Date: Wed, 6 Aug 2003 12:17:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: RaTao <ratao@toxyn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-linux-kernel@vger.kernel.orgtest2-mm4 O_DIRECT
Message-Id: <20030806121759.50a48626.akpm@osdl.org>
In-Reply-To: <3F30CFC1.1090205@toxyn.org>
References: <3F30CFC1.1090205@toxyn.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RaTao <ratao@toxyn.org> wrote:
>
> 
> Hi!
> 
> While testing linux-2.6.0-test2-mm4 I noticed two things:
> 
> - O_DIRECT doesn't work, at least in ext3, with block size different 
> from filesystem's blocksize. (It doesn't work with 512 bs, at least).
> This works in 2.6.0-test2, from 512 to 4096.

It works OK here.

> - vmstat doesn't show bi/bo for O_DIRECT's disk access.

It does here.


I'd be suspecting your test app: is it checking the return value of all
syscalls?

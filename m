Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTKUHtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbTKUHtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:49:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:61607 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264315AbTKUHtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:49:42 -0500
Date: Thu, 20 Nov 2003 23:55:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT leaks memory on linux-2.6.0-test9
Message-Id: <20031120235530.3d09882f.akpm@osdl.org>
In-Reply-To: <20031121073411.665A27007C@sv1.valinux.co.jp>
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp>
	<20031120231749.7cc3f245.akpm@osdl.org>
	<20031121073411.665A27007C@sv1.valinux.co.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
>
> It'll take a while to leak a noticable amount of memory. So I reduced
>  the amount of memory using a boot option.

Well I'll be darned.  I took a new version of fsstress and it happens here
too.  We're leaking anonymous memory.  -mm doesn't do any better, either.


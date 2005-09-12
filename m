Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVILJqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVILJqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVILJqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:46:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751268AbVILJqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:46:10 -0400
Date: Mon, 12 Sep 2005 02:41:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, torvalds@osdl.org,
       vojtech@suse.cz, dwmw2@infradead.org, netdev@vger.kernel.org,
       benjamin_kong@ali.com.tw, dagb@cs.uit.no, jgarzik@pobox.com,
       davidm@snapgear.com, twoller@crystal.cirrus.com, alan@redhat.com,
       mm@caldera.de, scott@spiteful.org, jsimmons@transvirtual.com
Subject: Re: pm_register should die
Message-Id: <20050912024145.3c4298ec.akpm@osdl.org>
In-Reply-To: <20050912093456.GA29205@elf.ucw.cz>
References: <20050912093456.GA29205@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +#ifdef CONFIG_OLD_PM
>   	if (pm_send_all(PM_SUSPEND, (void *)3)) {

Can we not do this without ifdefs?

#define pm_send_all(foo, bar) 0

?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265865AbUGHHTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUGHHTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGHHTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:19:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:55776 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265898AbUGHHRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:17:07 -0400
Date: Thu, 8 Jul 2004 00:15:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Cc: rth@redhat.com, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha print the symbol name in Oops
Message-Id: <20040708001547.0fa78731.akpm@osdl.org>
In-Reply-To: <cc723f5904070722341dcde1af@mail.gmail.com>
References: <cc723f5904070722341dcde1af@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
>
>  +		printk("[<%lx>]", tmp);
>  +		print_symbol(" %s\n", tmp);

print_symbol() does nothing at all if CONFIG_KALLSYMS=n.  You probably want:

	printk("[<%lx>]", tmp);
	print_symbol(" %s", tmp);
	printk("\n");


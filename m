Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUCHV35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUCHV3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:29:55 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:30607 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261263AbUCHV3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:29:38 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Pat Gefre <pfg@sgi.com>, davidm@napali.hpl.hp.com
Subject: Re: [2.6 PATCH] Altix - console driver calls console_initcall
Date: Mon, 8 Mar 2004 14:29:29 -0700
User-Agent: KMail/1.5.4
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200403082032.i28KWvuw082582@fsgi900.americas.sgi.com>
In-Reply-To: <200403082032.i28KWvuw082582@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081429.29622.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 1:32 pm, Pat Gefre wrote:
> -static void __init sn_sal_serial_console_init(void);
> +int __init sn_sal_serial_console_init(void);

I don't see any callers other than the console_initcall(), so
you could lose the declaration altogether.

> -static void __init
> +int __init
>  sn_sal_serial_console_init(void)

console_initcall() works fine with static functions, so you should
be able to keep this static.

Bjorn


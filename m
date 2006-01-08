Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWAHG6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWAHG6H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 01:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWAHG6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 01:58:07 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:28496 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750759AbWAHG6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 01:58:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Miloslav Trmac <mitr@volny.cz>
Subject: Re: [PATCH] wistron_btns: Fix missing BIOS signature handling
Date: Sun, 8 Jan 2006 01:58:03 -0500
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43C0B3BF.5050100@volny.cz>
In-Reply-To: <43C0B3BF.5050100@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601080158.04175.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 01:39, Miloslav Trmac wrote:
> offset can never be < 0 because it has type size_t.  The driver
> currently oopses on insmod if BIOS does not support the interface,
> instead of refusing to load.
> 

I don't really like that casting, should we just change offset to ssize_t?

-- 
Dmitry

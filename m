Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUEVKZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUEVKZG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 06:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbUEVKZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 06:25:06 -0400
Received: from niit.caravan.ru ([217.23.131.158]:30984 "EHLO mail.tv-sign.ru")
	by vger.kernel.org with ESMTP id S264953AbUEVKZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 06:25:03 -0400
Message-ID: <40AF2AF4.9079831E@tv-sign.ru>
Date: Sat, 22 May 2004 14:27:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.6-mm5
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
>
> +ia32-fault-deadlock-fix.patch
>
> +	if ((error_code & 4) == 0 && !check_exception(regs))
> +		goto bad_area_nosemaphore;


I just can't understand, why check_exception() was introduced.
if ((error_code & 4) == 0 && !search_exception_tables(regs->eip))
has the same effect?

Oleg.

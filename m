Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVERJQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVERJQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVERJQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:16:14 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:34966 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262136AbVERJQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:16:11 -0400
Message-ID: <428B09A6.DD188E8D@tv-sign.ru>
Date: Wed, 18 May 2005 13:23:50 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Optimize sys_times for a single thread process
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
>
> +#ifdef CONFIG_SMP
> +		if (current == next_thread(current)) {
> +			/*
> +			 * Single thread case without the use of any locks.

A nitpick, but wouldn't be it clearer to to use
thread_group_empty(current)?

Oleg.
